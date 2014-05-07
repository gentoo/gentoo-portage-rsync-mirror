# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nanoc/nanoc-3.6.5.ebuild,v 1.2 2014/05/07 19:07:52 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

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

DEPEND+="test? ( app-text/asciidoc app-text/highlight )"

ruby_add_rdepend "!minimal? (
	dev-ruby/mime-types
	dev-ruby/rack
)
	>=dev-ruby/cri-2.3:0"

ruby_add_bdepend "test? (
	>=dev-ruby/mocha-0.13
	dev-ruby/minitest
	=dev-ruby/rdoc-4*
	dev-ruby/systemu
	dev-ruby/yard
)
doc? (
	dev-ruby/kramdown
	dev-ruby/rdiscount
	dev-ruby/yard
)"

all_ruby_prepare() {
	use doc || use test || (rm tasks/doc.rake || die)
	use test || (rm tasks/test.rake || die)

	rm Gemfile.lock || die

	# Avoid non-optional tests for w3c_validators which we don't have
	# packaged and which require network access.
	rm test/extra/checking/checks/test_{css,html}.rb || die

	# Skip a test that produces slightly different javascript.
	sed -i -e '/test_filter_with_options/,/^  end/ s:^:#:' test/filters/test_uglify_js.rb || die
}
