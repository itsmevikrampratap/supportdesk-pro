enum EngineerStatus { online, busy, offline }

class TeamMember {
  final String name;
  final String role;
  final String email;
  final String imageUrl;
  final EngineerStatus status;
  final int activeTicketsCount;
  final List<String> skills;

  TeamMember({
    required this.name,
    required this.role,
    required this.email,
    required this.imageUrl,
    required this.status,
    required this.activeTicketsCount,
    required this.skills,
  });
}