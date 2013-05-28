# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/python-mode/python-mode-0.6.18.ebuild,v 1.1 2013/05/28 19:17:48 radhermit Exp $

EAPI=5

VIM_PLUGIN_MESSAGES="filetype"
VIM_PLUGIN_HELPFILES="PythonModeCommands"
VIM_PLUGIN_HELPURI="https://github.com/klen/python-mode"

inherit vim-plugin

DESCRIPTION="Provide python code looking for bugs, refactoring and other useful things"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3770 https://github.com/klen/python-mode"
SRC_URI="https://github.com/klen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/astng
	dev-python/autopep8
	dev-python/pyflakes
	dev-python/pylint
	dev-python/rope
	dev-python/ropemode
	"

src_prepare() {
	rm -rf pylibs/{logilab,*pep8.py,pyflakes,pylint,rope,ropemode} .gitignore
	mv pylint.ini "${T}" || die
	sed -e "s|expand(\"<sfile>:p:h:h\")|\"${EPREFIX}/usr/share/${PN}\"|" \
		-i autoload/pymode.vim || die # use custom path
	sed -e "s/pylibs.autopep8/autopep8/g" -i pylibs/pymode/auto.py || die
	sed -e "s/pylibs.ropemode/ropemode/g" -i pylibs/ropevim.py || die
}

src_install() {
	vim-plugin_src_install
	insinto usr/share/${PN}
	doins "${T}"/pylint.ini
}

pkg_postinst() {
	vim-plugin_pkg_postinst
	einfo "If you use custom pylintrc make sure you append the contents of"
	einfo " ${EPREFIX}/usr/share/${PN}/pylint.ini"
	einfo "to it. Otherwise PyLint command will not work properly."
}
