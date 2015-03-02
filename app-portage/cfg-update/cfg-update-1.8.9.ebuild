# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/cfg-update/cfg-update-1.8.9.ebuild,v 1.4 2015/03/02 09:31:45 ago Exp $

EAPI=5
inherit eutils

DESCRIPTION="Easy to use GUI & CLI alternative for etc-update with safe automatic updating functionality"
HOMEPAGE="https://github.com/rich0/cfg-update"
SRC_URI="https://github.com/rich0/cfg-update/tarball/${PV} -> ${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE="X"

RDEPEND="X? ( >=x11-misc/sux-1.0
	x11-apps/xhost )
	dev-perl/TermReadKey"

S="${WORKDIR}/rich0-cfg-update-2f10786"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

pkg_prerm() {
	if [[ ${ROOT} == / ]]
	then
		ebegin "Disabling portage hook"
		cfg-update --ebuild --disable-portage-hook
		eend $?
		ebegin "Disabling paludis hook"
		cfg-update --ebuild --disable-paludis-hook
		eend $?
	fi
}

pkg_postrm() {
	ewarn
	ewarn "If you want to permanently remove cfg-update from your system"
	ewarn "you should remove the index file /var/lib/cfg-update/checksum.index"
	ewarn
}

src_install() {
	exeinto /usr/bin
	doexe cfg-update emerge_with_indexing_for_cfg-update emerge_with_indexing_for_cfg-update_phphelper cfg-update_phphelper emerge_with_indexing_for_cfg-update_bashhelper
	insinto /usr/lib/cfg-update
	doins cfg-update cfg-update_indexing test.tgz
	dodoc ChangeLog
	doman *.8
	insinto /etc
	doins cfg-update.conf
	doins cfg-update.hosts
	keepdir /var/lib/cfg-update
}

pkg_postinst() {
	if [[ ! -e "${ROOT}"/var/lib/cfg-update/checksum.index \
		&& -e "${ROOT}"/var/lib/cfg-update/checksum.index ]]
	then
		ebegin "Moving checksum.index from /usr/lib/cfg-update to /var/lib/cfg-update"
		mv "${ROOT}"/usr/lib/cfg-update/checksum.index \
			"${ROOT}"/var/lib/cfg-update/checksum.index
		eend $?
	fi

	if [[ -e "${ROOT}"/usr/bin/paludis ]]
	then
		ewarn
		ewarn "If you have used Paludis version <0.20.0 on your system, chances are"
		ewarn "that you have some corrupted CONTENTS files on your system..."
		ewarn
		ewarn "Please run: cfg-update --check-packages"
		ewarn
		ewarn "The above command will check all packages installed with Paludis and"
		ewarn "will output a list of packages that need to be re-installed with"
		ewarn "Paludis 0.20.0 or higher. If you do not re-install these packages"
		ewarn "you risk losing your custom settings when updating configuration"
		ewarn "files, that belong to these packages, with cfg-update!"
		ewarn
	fi

	if [[ ${ROOT} == / ]]
	then
		ebegin "Moving backups to /var/lib/cfg-update/backups"
		/usr/bin/cfg-update --ebuild --move-backups
		eend $?
	fi

	einfo
	einfo "If this is a first time install, please check the configuration"
	einfo "in /etc/cfg-update.conf before using cfg-update:"
	einfo
	einfo "If your system does not have an X-server installed you need to"
	einfo "change the MERGE_TOOL to sdiff, imediff2 or vimdiff."
	einfo "If you have X installed, set MERGE_TOOL to your favorite GUI tool:"
	einfo "xxdiff, beediff, kdiff3, meld (default), gtkdiff, gvimdiff, tkdiff"
	einfo
	einfo "TIP: to maximize the chances of future automatic updates, run:"
	einfo "cfg-update --optimize-backups"
	einfo
}
