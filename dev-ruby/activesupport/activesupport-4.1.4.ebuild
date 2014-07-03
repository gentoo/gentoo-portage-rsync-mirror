# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-4.1.4.ebuild,v 1.1 2014/07/03 06:19:30 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activesupport.gemspec"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem versionator

DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"
SRC_URI="https://github.com/rails/rails/archive/v${PV}.tar.gz -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "
	>=dev-ruby/i18n-0.6.9:0.6
	>=dev-ruby/json-1.7.7:0
	>=dev-ruby/tzinfo-1.1:1
	>=dev-ruby/minitest-5.1:5
	>=dev-ruby/thread_safe-0.1:0"

# memcache-client, nokogiri, and builder are not strictly
# needed, but there are tests using this code.
ruby_add_bdepend "test? (
	>=dev-ruby/dalli-2.2.1
	>=dev-ruby/nokogiri-1.4.5
	>=dev-ruby/builder-3.1.0
	>=dev-ruby/libxml-2.0.0
	)"

all_ruby_prepare() {
	# Set the secure permissions that tests expect.
	chmod 0755 "${HOME}" || die "Failed to fix permissions on home"

	# Set test environment to our hand.
#	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/load_paths/d' test/abstract_unit.rb || die "Unable to remove load paths"
}
