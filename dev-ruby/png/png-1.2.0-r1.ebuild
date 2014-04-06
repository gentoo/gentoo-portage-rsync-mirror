# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/png/png-1.2.0-r1.ebuild,v 1.5 2014/04/05 23:23:31 mrueg Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="An almost pure-Ruby Portable Network Graphics (PNG) library."
HOMEPAGE="http://rubyforge.org/projects/seattlerb/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "
	doc? ( dev-ruby/hoe )
	test? (
		dev-ruby/hoe
		dev-ruby/minitest
	)"

ruby_add_rdepend ">=dev-ruby/RubyInline-3.5.0"

src_test() {
	chmod 0755 "${HOME}" || die "Failed to fix permissions on home."
	ruby-ng_src_test
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r example
}
