# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nanoc/nanoc-3.4.3.ebuild,v 1.1 2012/12/11 18:57:01 graaff Exp $

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

DEPEND+="test? ( app-text/asciidoc app-text/highlight )"

ruby_add_rdepend "!minimal? (
	dev-ruby/mime-types
	dev-ruby/rack
)
	>=dev-ruby/cri-2.2"

ruby_add_bdepend "test? (
	dev-ruby/fssm
	dev-ruby/mocha
	dev-ruby/minitest
	dev-ruby/systemu
)
doc? (
	dev-ruby/kramdown
	dev-ruby/rdiscount
	dev-ruby/yard
)"

all_ruby_prepare() {
	use doc || (rm tasks/doc.rake || die)
	use test || (rm tasks/test.rake || die)
}
