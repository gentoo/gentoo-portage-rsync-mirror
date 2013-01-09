# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/autojump/autojump-21.3.0.ebuild,v 1.1 2013/01/09 09:06:26 xmw Exp $

EAPI=4

PYTHON_DEPEND="python? *"
SUPPORT_PYTHON_ABIS="1"

inherit python vcs-snapshot

DESCRIPTION="change directory command that learns"
HOMEPAGE="http://github.com/joelthelion/autojump"
SRC_URI="https://github.com/joelthelion/${PN}/archive/release-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion python test zsh-completion"

RDEPEND="bash-completion? ( >=app-shells/bash-4 )
	zsh-completion? ( app-shells/zsh app-shells/zsh-completion )"
DEPEND="test? ( dev-lang/python )"

src_prepare() {
	#https://github.com/joelthelion/autojump/issues/129
	sed -e '/def test_db_load_migrate/,/autojump.CONFIG_DIR = ORIG_CONFIG_DIR/d' \
		-i tests/runtests.py || die
}

src_compile() {
	true
}

src_install() {
	dobin bin/autojump

	insinto /etc/profile.d
	doins bin/${PN}.sh

	if use bash-completion ; then
		doins bin/${PN}.bash
	fi

	if use zsh-completion ; then
		doins bin/${PN}.zsh
		insinto /usr/share/zsh/site-functions
		doins bin/_j
	fi

	if use python ; then
		install_python() {
			insinto "$(python_get_sitedir)"
			doins tools/autojump_ipython.py
		}
		python_execute_function -q install_python

		einfo "This tool provides \"j\" for ipython, please add"
		einfo "\"imporrt autojump_ipython\" to your ipy_user_conf.py."
	fi

	doman docs/${PN}.1
	dodoc README.md
}
