# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/command-t/command-t-1.3.1.ebuild,v 1.2 2012/02/28 03:58:58 radhermit Exp $

EAPI="4"
USE_RUBY="ruby18 ruby19"

inherit vim-plugin ruby-ng

DESCRIPTION="vim plugin: fast file navigation for vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3025
	https://wincent.com/products/command-t"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.bz2"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

RDEPEND="|| ( app-editors/vim[ruby] app-editors/gvim[ruby] )"

each_ruby_configure() {
	cd ruby/${PN}
	${RUBY} extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	cd ruby/${PN}
	emake
	rm *.o *.c *.h *.log extconf.rb depend Makefile || die
}

each_ruby_install() {
	local sitelibdir=$(ruby_rbconfig_value "sitelibdir")
	insinto ${sitelibdir}/${PN}
	doins -r ruby/${PN}/*
}

all_ruby_install() {
	rm -r ruby || die
	vim-plugin_src_install
}
