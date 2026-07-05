import 'package:flutter/material.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({Key? key}) : super(key: key);

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _customerController = TextEditingController();
  final _emailController = TextEditingController();

  String _selectedCategory = "Integration";
  String _selectedPriority = "Medium";

  void _submitTicket() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ticket logged successfully into tracking buffer.")),
      );
      _subjectController.clear();
      _descriptionController.clear();
      _customerController.clear();
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generate New Incident Ticket")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: "Ticket Subject Summary",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty) ? "Please write a concise subject summary" : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true, // Solves the internal layout overflow
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: "Category", // Cleaner, concise label
                        border: OutlineInputBorder(),
                      ),
                      items: ["Integration", "Authentication", "Billing", "Mobile App", "Infrastructure"]
                          .map((val) => DropdownMenuItem(
                        value: val,
                        child: Text(val, overflow: TextOverflow.ellipsis),
                      ))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedCategory = val ?? "Integration"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true, // Solves the internal layout overflow
                      value: _selectedPriority,
                      decoration: const InputDecoration(
                        labelText: "Priority", // Cleaner, concise label
                        border: OutlineInputBorder(),
                      ),
                      items: ["Low", "Medium", "High", "Urgent"]
                          .map((val) => DropdownMenuItem(
                        value: val,
                        child: Text(val, overflow: TextOverflow.ellipsis),
                      ))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedPriority = val ?? "Medium"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _customerController,
                decoration: const InputDecoration(
                  labelText: "Client Corporate Name",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty) ? "Identify customer account source" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Client Technical Contact Email",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || !v.contains('@')) ? "Enter client verification email address" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: "Detailed Problem & Error Replication Steps",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (v) => (v == null || v.length < 10) ? "Clarify incident payload context" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  minimumSize: const Size(double.infinity, 54),
                ),
                child: const Text("Deploy Log Ticket", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}