# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionmailer/actionmailer-4.0.0.ebuild,v 1.2 2013/10/13 22:10:12 maekke Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="actionmailer.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Framework for designing email-service layers"
HOMEPAGE="http://rubyforge.org/projects/actionmailer/"
SRC_URI="http://github.com/rails/rails/archive/v${PV}.tar.gz -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm"
IUSE=""

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "~dev-ruby/actionpack-${PV}
	>=dev-ruby/mail-2.5.3:2.5"
ruby_add_bdepend "test? (
	dev-ruby/test-unit:2
	dev-ruby/mocha:0.13
)"

all_ruby_prepare() {
	# Set test environment to our hand.
	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/\/load_paths/d' test/abstract_unit.rb || die "Unable to remove load paths"

	# Make sure we use the test-unit gem since ruby18 does not provide
	# all the test-unit features needed.
	sed -i -e '1igem "test-unit"' test/abstract_unit.rb || die
}
