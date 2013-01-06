# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsearch/vdr-epgsearch-0.9.25_beta17.ebuild,v 1.3 2011/01/28 20:36:04 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder epgsearch plugin"
HOMEPAGE="http://winni.vdr-developer.org/epgsearch"

case ${P#*_} in
	rc*|beta*)
		MY_P="${P/_/.}"
		SRC_URI="http://winni.vdr-developer.org/epgsearch/downloads/beta/${MY_P}.tgz"
		S="${WORKDIR}/${MY_P#vdr-}"
		;;
	*)
		SRC_URI="http://winni.vdr-developer.org/epgsearch/downloads/${P}.tgz"
		;;
esac

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pcre tre"

DEPEND=">=media-video/vdr-1.3.45
	pcre? ( dev-libs/libpcre )
	tre? ( dev-libs/tre )"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	cd "${S}"
	fix_vdr_libsi_include conflictcheck.c

	# disable automagic deps
	sed -i Makefile -e '/^AUTOCONFIG=/s/^/#/'

	if use pcre; then
		einfo "Using pcre for regexp searches"
		sed -i Makefile -e 's/^#HAVE_PCREPOSIX/HAVE_PCREPOSIX/'
	fi

	if use tre; then
		einfo "Using tre for unlimited fuzzy searches"
		sed -i Makefile -e 's/^#HAVE_LIBTRE/HAVE_LIBTRE/'
	fi

	# install conf-file disabled
	sed -e '/^Menu/s:^:#:' -i conf/epgsearchmenu.conf
}

src_install() {
	vdr-plugin_src_install
	cd "${S}"
	diropts "-m755 -o vdr -g vdr"
	keepdir /etc/vdr/plugins/epgsearch
	insinto /etc/vdr/plugins/epgsearch

	doins conf/epgsearchmenu.conf
	doins conf/epgsearchconflmail.templ conf/epgsearchupdmail.templ

	dodoc conf/*.templ

	emake install-doc MANDIR="${D}/usr/share/man"
	dodoc MANUAL
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.9.18"
	previous_less_than_0_9_18=$?
}

pkg_postinst() {
	vdr-plugin_pkg_postinst
	if [[ $previous_less_than_0_9_18 = 0 ]] ; then
		elog "Moving config-files to new location /etc/vdr/plugins/epgsearch"
		cd "${ROOT}"/etc/vdr/plugins
		local f
		local moved=""
		for f in epgsearch*.* .epgsearch*; do
			[[ -e ${f} ]] || continue
			mv "${f}" "${ROOT}/etc/vdr/plugins/epgsearch"
			moved="${moved} ${f}"
		done
		elog "These files were moved:${moved}"
	fi
}
