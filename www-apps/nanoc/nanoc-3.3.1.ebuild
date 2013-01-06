# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nanoc/nanoc-3.3.1.ebuild,v 1.3 2012/05/12 07:00:27 a3li Exp $

EAPI="2"
USE_RUBY="ruby18"

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
	>=dev-ruby/cri-2"

ruby_add_bdepend "test? (
	dev-ruby/mocha
	dev-ruby/minitest
)
doc? (
	dev-ruby/kramdown
	dev-ruby/yard
)"

all_ruby_prepare() {
	use doc || (rm tasks/doc.rake || die)
	use test || (rm tasks/test.rake || die)
}
