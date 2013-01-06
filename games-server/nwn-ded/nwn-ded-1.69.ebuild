# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/nwn-ded/nwn-ded-1.69.ebuild,v 1.4 2012/12/28 17:55:51 tupone Exp $

inherit games

LANGUAGES="linguas_en"
DIALOG_URL_BASE=http://files.bioware.com/neverwinternights/dialog/

DESCRIPTION="Neverwinter Nights Dedicated server"
HOMEPAGE="http://nwn.bioware.com/downloads/standaloneserver.html"
SRC_URI="http://files.bioware.com/neverwinternights/updates/windows/server/NWNDedicatedServer${PV}.zip
	linguas_en? ( ${DIALOG_URL_BASE}/english/NWNEnglish${PV}dialog.zip )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="${LANGUAGES}"
RESTRICT="mirror strip"

DEPEND="app-arch/unzip"
RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${dir:1}/common/nwserver"

src_unpack() {
	mkdir common || die "Failed creating directory"
	cd common
	unpack NWNDedicatedServer${PV}.zip
	tar -zxf linuxdedserver${PV/./}.tar.gz || die "Failed unpacking linuxdedserver"
	rm -f *dedserver*.{tar.gz,sit,zip} *.exe *.dll
	cd ..
	local currentlocale=""
	local a
	for a in ${A}
	do
		if [ -z "${a/*dialog*/}" ] ; then
			if [ -z "${a/*English*/}" ]; then currentlocale="en"; fi
			if [ -z "${a/*French*/}" ]; then currentlocale="fr"; fi
			if [ -z "${a/*German*/}" ]; then currentlocale="de"; fi
			if [ -z "${a/*Italian*/}" ]; then currentlocale="it"; fi
			if [ -z "${a/*Spanish*/}" ]; then currentlocale="es"; fi
			if [ -z "${a/*Japanese*/}" ]; then currentlocale="ja"; fi
			mkdir ${currentlocale} || die "Failed creating directory"
			cd ${currentlocale}
			cp -rfl ../common/* . || die "Failed hard-linking to common directory"
			unpack "${a}"
			cd ..
		fi
	done
}

src_install() {
	dodir ${dir}

	local currentlocale
	for currentlocale in * ; do
		if [[ ${currentlocale} != "common" ]]
		then
			games_make_wrapper nwserver-${currentlocale} ./nwserver "${dir}/${currentlocale}" "${dir}/${currentlocale}"
		fi
	done

	mv * "${D}/${dir}"/ || die "Failed installing server"

	prepgamesdirs
	chmod -R g+w "${D}/${dir}"
}
