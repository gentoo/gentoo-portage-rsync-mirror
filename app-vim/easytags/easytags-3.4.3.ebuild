# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/easytags/easytags-3.4.3.ebuild,v 1.1 2013/09/01 23:05:27 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-single-r1 vim-plugin

DESCRIPTION="vim plugin: automated tag file generation and syntax highlighting"
HOMEPAGE="http://peterodding.com/code/vim/easytags/"
SRC_URI="https://github.com/xolox/vim-${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=app-vim/vim-misc-1.8.5
	dev-util/ctags"

VIM_PLUGIN_HELPFILES="${PN}.txt"

S=${WORKDIR}/vim-${P}

src_prepare() {
	# remove unnecessary files
	rm addon-info.json INSTALL.md README.md || die
}

src_install() {
	vim-plugin_src_install

	# fix scripts
	fperms 755 /usr/share/vim/vimfiles/misc/easytags/{normalize-tags,why-so-slow}.py
	python_fix_shebang "${ED}"/usr/share/vim/vimfiles/misc/easytags/{normalize-tags,why-so-slow}.py
}
