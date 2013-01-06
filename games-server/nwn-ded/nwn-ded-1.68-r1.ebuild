# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/nwn-ded/nwn-ded-1.68-r1.ebuild,v 1.3 2010/06/28 22:35:18 mr_bones_ Exp $

inherit games

LANGUAGES="linguas_en linguas_fr linguas_it linguas_es linguas_de linguas_ja"
DIALOG_URL_BASE=http://files.bioware.com/neverwinternights/dialog/

DESCRIPTION="Neverwinter Nights Dedicated server"
HOMEPAGE="http://nwn.bioware.com/downloads/standaloneserver.html"
SRC_URI="http://files.bioware.com/neverwinternights/updates/windows/server/NWNDedicatedServer${PV}.zip
	linguas_en? ( ${DIALOG_URL_BASE}/english/NWNEnglish${PV}dialog.zip )
	linguas_fr? ( ${DIALOG_URL_BASE}/french/NWNFrench${PV}dialog.zip )
	linguas_de? ( ${DIALOG_URL_BASE}/german/NWNGerman${PV}dialog.zip )
	linguas_it? ( ${DIALOG_URL_BASE}/italian/NWNItalian${PV}dialog.zip )
	linguas_es? ( ${DIALOG_URL_BASE}/spanish/NWNSpanish${PV}dialog.zip )
	linguas_ja? ( ${DIALOG_URL_BASE}/japanese/NWNJapanese${PV}dialog.zip )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="${LANGUAGES}"
RESTRICT="mirror strip"

DEPEND="app-arch/unzip"
RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat )"

S=${WORKDIR}

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
	local dir=${GAMES_PREFIX_OPT}/${PN}
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
