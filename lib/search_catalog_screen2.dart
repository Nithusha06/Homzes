import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/property.dart';

class SearchCatalogScreen2 extends StatefulWidget {
  @override
  _SearchCatalogScreen2State createState() => _SearchCatalogScreen2State();
}

class _SearchCatalogScreen2State extends State<SearchCatalogScreen2> with SingleTickerProviderStateMixin {
  final FirebaseService _firebaseService = FirebaseService();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  List<Property> properties = [];
  Set<String> favorites = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
      _loadProperties();
    });
  }

  Future<void> _loadProperties() async {
    try {
      final loadedProperties = await _firebaseService.getProperties();
      setState(() {
        properties = loadedProperties;
      });
    } catch (e) {
      print('Error loading properties: $e');
    }
  }

  void _toggleFavorite(String propertyTitle) {
    setState(() {
      if (favorites.contains(propertyTitle)) {
        favorites.remove(propertyTitle);
      } else {
        favorites.add(propertyTitle);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFC6E7BE),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Color(0xFF282828),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white, size: 26),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(
                            Icons.search,
                            color: Colors.grey[600],
                            size: 26,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: properties.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1.5, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(
                      index * 0.2,
                      1.0,
                      curve: Curves.easeOutCubic,
                    ),
                  )),
                  child: PropertyListCard(
                    property: properties[index],
                    isFavorite: favorites.contains(properties[index].title),
                    onFavoritePressed: () => _toggleFavorite(properties[index].title),
                  ),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class AnimatedHeartIcon extends StatefulWidget {
  final bool isFavorite;

  const AnimatedHeartIcon({required this.isFavorite});

  @override
  _AnimatedHeartIconState createState() => _AnimatedHeartIconState();
}

class _AnimatedHeartIconState extends State<AnimatedHeartIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Icon(
        Icons.favorite_border,
        color: Colors.black,
        size: 20,
      ),
    );
  }
}

class PropertyListCard extends StatefulWidget {
  final Property property;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const PropertyListCard({
    required this.property,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  _PropertyListCardState createState() => _PropertyListCardState();
}

class _PropertyListCardState extends State<PropertyListCard> with SingleTickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<double> _imageScale;

  @override
  void initState() {
    super.initState();
    _imageController = AnimationController(
      duration: Duration(seconds: 10), // Slow animation for subtle effect
      vsync: this,
    )..repeat(reverse: true);

    _imageScale = Tween<double>(
      begin: 1.0,
      end: 1.1, // Subtle zoom effect
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Animated Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AnimatedBuilder(
                  animation: _imageController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _imageScale.value,
                      child: Image.network(
                        widget.property.imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              // Beds and Bathroom info
              Positioned(
                left: 12,
                bottom: 12,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${widget.property.beds} Beds',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${widget.property.bathrooms} Bathroom',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Favorite button with existing animation
              Positioned(
                right: 12,
                top: 12,
                child: GestureDetector(
                  onTap: widget.onFavoritePressed,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedHeartIcon(
                      isFavorite: widget.isFavorite,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.property.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '\$${widget.property.price}/mo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Russia, Moscow',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
} 