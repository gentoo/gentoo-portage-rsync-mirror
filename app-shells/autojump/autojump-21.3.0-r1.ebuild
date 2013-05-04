# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/autojump/autojump-21.3.0-r1.ebuild,v 1.1 2013/05/04 10:43:19 xmw Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} )

inherit eutils python-r1 vcs-snapshot

DESCRIPTION="change directory command that learns"
HOMEPAGE="http://github.com/joelthelion/autojump"
SRC_URI="https://github.com/joelthelion/${PN}/archive/release-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion python test zsh-completion"

RDEPEND="bash-completion? ( >=app-shells/bash-4 )
	python? ( ${PYTHON_DEPS} )
	zsh-completion? ( app-shells/zsh app-shells/zsh-completion )"
DEPEND="test? ( ${PYTHON_DEPS} )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-supported-shells.patch
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

	elog "loading of insecure relative path \"custom_install\" has been"
	elog "remove. See ${EPREFIX}/etc/profile.d/${PN}.sh for details."
}
