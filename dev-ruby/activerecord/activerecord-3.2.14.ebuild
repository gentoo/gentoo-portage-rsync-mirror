# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activerecord/activerecord-3.2.14.ebuild,v 1.1 2013/08/17 10:32:26 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

# this is not null so that the dependencies will actually be filled
RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activerecord.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Implements the ActiveRecord pattern (Fowler, PoEAA) for ORM"
HOMEPAGE="http://rubyforge.org/projects/activerecord/"
SRC_URI="http://github.com/rails/rails/archive/v${PV}.tar.gz -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="mysql postgres sqlite3"

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "~dev-ruby/activesupport-${PV}
	~dev-ruby/activemodel-${PV}
	>=dev-ruby/arel-3.0.2:3.0
	>=dev-ruby/tzinfo-0.3.29
	sqlite3? ( >=dev-ruby/sqlite3-1.3.5 )
	mysql? ( >=dev-ruby/mysql2-0.3.10:0.3 )
	postgres? ( >=dev-ruby/pg-0.11.0 )"

ruby_add_bdepend "
	test? (
		dev-ruby/bundler
		~dev-ruby/actionpack-${PV}
		>=dev-ruby/sqlite3-1.3.5
		dev-ruby/mocha:0.13
	)"

all_ruby_prepare() {
	# Remove items from the common Gemfile that we don't need for this
	# test run. This also requires handling some gemspecs.
	sed -i -e "/\(uglifier\|system_timer\|sdoc\|w3c_validators\|pg\|jquery-rails\|'mysql'\|journey\|ruby-prof\|benchmark-ips\)/d" ../Gemfile || die
	sed -i -e '/rack-ssl/d' -e 's/~> 3.4/>= 3.4/' ../railties/railties.gemspec || die
	sed -i -e '/mail/d' ../actionmailer/actionmailer.gemspec || die

	sed -i -e '/bcrypt/ s/3.0.0/3.0/' ../Gemfile || die

	# Avoid tests depending on hash ordering
	sed -i -e '/test_should_automatically_build_new_associated/,/ end/ s:^:#:' test/cases/nested_attributes_test.rb || die

	# Avoid test depending on mysql adapter which we don't support for
	# this Rails version to simplify our dependencies.
	rm test/cases/connection_specification/resolver_test.rb || die
}

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			;;
		*rubyee18)
			# Turn on travis support to avoid tripping bugs in ree18.
			TRAVIS=true ${RUBY} -S rake test_sqlite3
			;;
		*)
			if use sqlite3; then
				${RUBY} -S rake test_sqlite3 || die "sqlite3 tests failed"
			fi
			;;
	esac
}
