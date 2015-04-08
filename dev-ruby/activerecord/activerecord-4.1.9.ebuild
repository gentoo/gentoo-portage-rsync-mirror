# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activerecord/activerecord-4.1.9.ebuild,v 1.1 2015/01/07 07:05:49 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

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
KEYWORDS="~amd64 ~arm ~ppc ~ppc64"
IUSE="mysql postgres sqlite3"

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "~dev-ruby/activesupport-${PV}
	~dev-ruby/activemodel-${PV}
	>=dev-ruby/arel-5.0.0:5.0
	sqlite3? ( >=dev-ruby/sqlite3-1.3.6 )
	mysql? ( >=dev-ruby/mysql2-0.3.13:0.3 )
	postgres? ( >=dev-ruby/pg-0.11.0 )"

ruby_add_bdepend "
	test? (
		dev-ruby/bundler
		~dev-ruby/actionpack-${PV}
		>=dev-ruby/sqlite3-1.3.5
		dev-ruby/mocha:0.13
		<dev-ruby/minitest-5.3.4:5
	)"

all_ruby_prepare() {
	# Remove items from the common Gemfile that we don't need for this
	# test run. This also requires handling some gemspecs.
	sed -i -e "/\(uglifier\|system_timer\|sdoc\|w3c_validators\|pg\|jquery-rails\|'mysql'\|journey\|ruby-prof\|benchmark-ips\|kindlerb\|turbolinks\|coffee-rails\|debugger\|redcarpet\|minitest\)/ s:^:#:" ../Gemfile || die
	sed -i -e '/rack-ssl/d' -e 's/~> 3.4/>= 3.4/' ../railties/railties.gemspec || die
	sed -i -e '/mail/d' ../actionmailer/actionmailer.gemspec || die

	sed -i -e '/bcrypt/ s/3.0.0/3.0/' ../Gemfile || die

	# Add back json in the Gemfile because we dropped some dependencies
	# earlier that implicitly required it.
	sed -i -e '$agem "json"' ../Gemfile || die

	# Avoid test depending on mysql adapter which we don't support for
	# this Rails version to simplify our dependencies.
	rm test/cases/connection_specification/resolver_test.rb || die

	# Avoid single test using mysql dependencies.
	rm test/cases/invalid_connection_test.rb || die
}

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			;;
		*)
			if use sqlite3; then
				${RUBY} -S rake test_sqlite3 || die "sqlite3 tests failed"
			fi
			;;
	esac
}
