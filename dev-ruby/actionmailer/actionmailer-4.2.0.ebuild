# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionmailer/actionmailer-4.2.0.ebuild,v 1.4 2015/01/08 20:58:13 maekke Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="actionmailer.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Framework for designing email-service layers"
HOMEPAGE="https://github.com/rails/rails"
SRC_URI="http://github.com/rails/rails/archive/v${PV}.tar.gz -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64"
IUSE=""

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "
	~dev-ruby/actionpack-${PV}
	~dev-ruby/actionview-${PV}
	~dev-ruby/activejob-${PV}
	>=dev-ruby/mail-2.5.4:2.5
	>=dev-ruby/rails-dom-testing-1.0.5:1"

ruby_add_bdepend "test? (
	dev-ruby/test-unit:2
	dev-ruby/mocha:0.14
)"

all_ruby_prepare() {
	# Set test environment to our hand.
	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/\/load_paths/d' test/abstract_unit.rb || die "Unable to remove load paths"

	# Make sure we use the test-unit gem since ruby18 does not provide
	# all the test-unit features needed.
	sed -i -e '1igem "test-unit"' test/abstract_unit.rb || die

	# Avoid a test failing only on attachment ordering, since this is a
	# security release.
	sed -i -e '/adding inline attachments while rendering mail works/askip "gentoo: fails on ordering"' test/base_test.rb || die
}
