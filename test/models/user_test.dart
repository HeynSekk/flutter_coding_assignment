import 'package:flutter_sample_app/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart' as repo;

void main() {
  group('user', () {
    test('transform repo User to current package User object correctly',
        () async {
      const repo.User repoUser = repo.User(
        id: 1,
        name: 'user.name',
        username: 'user.username',
        email: 'user.email',
        address: repo.Address(
          street: 'user.address?.street',
          suite: 'user.address?.suite',
          city: 'user.address?.city',
          zipcode: 'user.address?.zipcode',
          geo: repo.Geo(
            lat: 'user.address?.geo?.lat',
            lng: 'user.address?.geo?.lng',
          ),
        ),
        phone: 'user.phone',
        website: 'user.website',
        company: repo.Company(
          name: 'user.company?.name',
          catchPhrase: 'user.company?.catchPhrase',
          bs: 'user.company?.bs',
        ),
      );
      const User user = User(
        id: 1,
        name: 'user.name',
        username: 'user.username',
        email: 'user.email',
        address: Address(
          street: 'user.address?.street',
          suite: 'user.address?.suite',
          city: 'user.address?.city',
          zipcode: 'user.address?.zipcode',
          geo: Geo(
            lat: 'user.address?.geo?.lat',
            lng: 'user.address?.geo?.lng',
          ),
        ),
        phone: 'user.phone',
        website: 'user.website',
        company: Company(
          name: 'user.company?.name',
          catchPhrase: 'user.company?.catchPhrase',
          bs: 'user.company?.bs',
        ),
      );
      expect(
        User.fromRepo(repoUser),
        user,
      );
    });
  });
}
