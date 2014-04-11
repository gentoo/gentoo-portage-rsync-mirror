# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/rex-client/rex-client-9999.ebuild,v 1.3 2014/04/11 09:21:35 patrick Exp $

EAPI="4"

DESCRIPTION="REX - Remote EXexcution agent"
HOMEPAGE="http://mduft.github.io/rex/"

if [[ ${PV} == 9999 ]]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/mduft/rex.git"
	EGIT_PROJECT="${PN}"
else
	SRC_URI=""
	KEYWORDS="~x86-linux"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

REX_EXE=( "client/rex-exec.sh" "client/rex-register.sh" "client/rex-paths.sh" "client/rex-remote-pconv.sh" "client/winpath2unix" "client/unixpath2win" )

src_prepare() {
	for x in ${REX_EXE[@]}; do
		sed -i -e "s,\. \${HOME}/rex-config.sh,\. ${EPREFIX}/etc/rex.conf,g" "${x}"
	done
}

src_install() {
	exeinto /usr/bin
	for x in ${REX_EXE[@]}; do
		doexe "${S}"/${x}
	done

	insinto /etc
	newins client/rex-config.sh rex.conf
}
