import 'package:flutter/material.dart';

class TempConverterScreen extends StatefulWidget {
  const TempConverterScreen({super.key});

  @override
  State<TempConverterScreen> createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  final TextEditingController _temperatureController = TextEditingController();
  bool _isFahrenheitToCelsius = true; // true for fahrenheit to celsius
  String _result = '';
  final List<String> _history = [];

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  // conversion method
  void _convertTemperature() {
    // check if the input is empty
    if (_temperatureController.text.isEmpty) {
      _showErrorDialog('Please enter a temperature value');
      return;
    }

    // check if the input is a valid number
    double? temperature = double.tryParse(_temperatureController.text);
    if (temperature == null) {
      _showErrorDialog('Please enter a valid number');
      return;
    }

    double convertedTemp;
    String historyEntry;

    if (_isFahrenheitToCelsius) {
      // convert from fahrenheit to celsius
      convertedTemp = (temperature - 32) * 5 / 9;
      historyEntry =
          'F to C: ${temperature.toStringAsFixed(2)} => ${convertedTemp.toStringAsFixed(2)}';
    } else {
      // convert from celsius to fahrenheit
      convertedTemp = (temperature * 9 / 5) + 32;
      historyEntry =
          'C to F: ${temperature.toStringAsFixed(2)} => ${convertedTemp.toStringAsFixed(2)}';
    }

    setState(() {
      _result = convertedTemp.toStringAsFixed(2);
      _history.insert(0, historyEntry); // add to the top of the list
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  // clear the conversions history
  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Converter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade300,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildConverterCard(),
            const SizedBox(height: 20),
            _buildHistoryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildConverterCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Conversion:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // conversion type selection
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Fahrenheit to Celsius'),
                    value: true,
                    groupValue: _isFahrenheitToCelsius,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFahrenheitToCelsius = value!;
                        _result =
                            ''; // clear the result when changing conversion type
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Celsius to Fahrenheit'),
                    value: false,
                    groupValue: _isFahrenheitToCelsius,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFahrenheitToCelsius = value!;
                        _result =
                            ''; // clear the result when changing conversion type
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // temperature input and the result display
            Row(
              children: [
                // input textfield
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // Gray background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: TextField(
                      controller: _temperatureController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textAlign: TextAlign.center, // Center the input text
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Remove borders
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        hintText: 'Enter value',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Equals sign
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    '=',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Result display
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // Gray background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: Text(
                      _result.isEmpty ? 'Result' : '$_result',
                      textAlign: TextAlign.center, // Center the result text
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: _result.isEmpty ? Colors.grey : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // convert button
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
              ),
              child: const Text('Convert', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Conversation history',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (!_history.isEmpty)
                  TextButton(
                    onPressed: _clearHistory,
                    child: const Text('clear'),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            if (_history.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'No conversions yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 100),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(
                          _history[index],
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
