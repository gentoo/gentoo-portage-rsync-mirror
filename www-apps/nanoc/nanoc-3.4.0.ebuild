# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nanoc/nanoc-3.4.0.ebuild,v 1.1 2012/08/13 19:14:32 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_EXTRADOC="ChangeLog NEWS.md README.md"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_TASK_TEST="test"

inherit ruby-fakegem

DESCRIPTION="nanoc is a simple but very flexible static site generator written in Ruby."
HOMEPAGE="http://nanoc.stoneship.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="${IUSE} minimal"

ruby_add_rdepend "!minimal? (
	dev-ruby/mime-types
	dev-ruby/rack
)
	>=dev-ruby/cri-2.2"

ruby_add_bdepend "test? (
	dev-ruby/mocha
	dev-ruby/minitest
)
doc? (
	dev-ruby/kramdown
	dev-ruby/rdiscount
	dev-ruby/yard
)"

all_ruby_prepare() {
	use doc || (rm tasks/doc.rake || die)
	use test || (rm tasks/test.rake || die)

	# Remove failing uglify tests that seem wrong and fragile.
	# https://github.com/ddfreyne/nanoc/issues/137
	rm test/filters/test_uglify_js.rb || die
}
