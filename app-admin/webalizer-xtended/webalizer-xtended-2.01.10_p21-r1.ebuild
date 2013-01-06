# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webalizer-xtended/webalizer-xtended-2.01.10_p21-r1.ebuild,v 1.1 2012/02/16 01:38:14 jer Exp $

# uses webapp.eclass to create directories with right permissions
# probably slight overkill but works well

EAPI="2"

inherit autotools confutils db-use eutils versionator webapp

WEBAPP_MANUAL_SLOT="yes"

MY_PV="$(get_version_component_range 1-2)-$(get_version_component_range 3)"
WEBALIZER_P="webalizer-${MY_PV}"

DESCRIPTION="Webserver log file analyzer"
HOMEPAGE="http://www.patrickfrei.ch/webalizer/index.html"
SRC_URI="ftp://ftp.mrunix.net/pub/webalizer/old/${WEBALIZER_P}-src.tar.bz2
	http://patrickfrei.ch/webalizer/rb${PV/*_p/}/webalizer-${MY_PV}-RB${PV/*_p/}-patch.tar.gz
	mirror://gentoo/webalizer.conf.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="geoip nls"
SLOT="0"

DEPEND=">=sys-libs/db-4.2
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=media-libs/gd-1.8.3
	geoip? ( dev-libs/geoip )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${WEBALIZER_P}

pkg_setup() {
	webapp_pkg_setup
	confutils_require_built_with_all media-libs/gd png

	# USE=nls has no real meaning if LINGUAS isn't set
	if use nls && [[ -z "${LINGUAS}" ]]; then
		ewarn "you must set LINGUAS in /etc/make.conf"
		ewarn "if you want to USE=nls"
		die "please either set LINGUAS or do not use nls"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/webalizer-db4.2.patch \
		"${WORKDIR}"/webalizer-${MY_PV}-RB${PV/*_p/}-patch \
		"${FILESDIR}"/${P}-etc-webalizer-xtended-conf.patch \
		"${FILESDIR}"/${P}-strip.patch \
		"${FILESDIR}"/${P}-static-libs.patch

	eautoreconf
}

src_configure() {
	# really dirty hack; necessary due to a really gross ./configure
	# basically, it just sets the natural language the program uses
	# unfortunatly, this program only allows for one lang, so only the first
	# entry in LINGUAS is used
	if use nls; then
		local longlang="$(grep ^${LINGUAS:0:2} "${FILESDIR}"/webalizer-language-list.txt)"
		local myconf="${myconf} --with-language=${longlang:3}"
	else
		local myconf="${myconf} --with-language=english"
	fi

	if use geoip ; then
		# Rationale:
		# 1. --enable-geoip broken on geolizer
		# 2. --disable-geoip broken on webalizer xtended
		myconf="${myconf} --enable-geoip"
	fi

	econf --enable-dns \
		--with-db=$(db_includedir) \
		--with-dblib=$(db_libname) \
		${myconf} \
		|| die "econf failed"
}

src_install() {
	webapp_src_preinst

	newbin webalizer webalizer-xtended
	fperms 755 /usr/bin/webalizer-xtended || die 'fperms failed'
	dosym webalizer-xtended /usr/bin/webazolver-xtended || die 'dosym failed'
	newman webalizer.1 webalizer-xtended.1 || die 'newman failed'

	insinto /etc
	newins "${WORKDIR}"/webalizer.conf webalizer-xtended.conf || die 'doins failed'
	dosed "s/apache/apache2/g" /etc/webalizer-xtended.conf

	dodoc CHANGES *README* INSTALL sample.conf "${FILESDIR}"/apache.webalizer-xtended

	webapp_src_install
}

pkg_postinst() {
	elog
	elog "It is suggested that you restart apache before using webalizer"
	elog "xtended.  You may want to review /etc/webalizer-xtended.conf"
	elog "and ensure that OutputDir is set correctly."
	elog
	elog "Then just type webalizer-xtended to generate your stats."
	elog "You can also use cron to generate them e.g. every day."
	elog "They can be accessed via http://localhost/webalizer-xtended"
	elog
	elog "A sample Apache config file has been installed into"
	elog "/usr/share/doc/${PF}/apache.webalizer-xtended"
	elog "Please edit and install it as necessary"
	elog

	if [[ ${#LINGUAS} -gt 2 ]] && use nls; then
		ewarn
		ewarn "You have more than one language in LINGUAS"
		ewarn "Due to the limitations of this packge, it was built"
		ewarn "only with ${LINGUAS:0:2} support. If this is not what"
		ewarn "you intended, please place the language you desire"
		ewarn "_first_ in the list of LINGUAS in /etc/make.conf"
		ewarn
	fi

	elog "Read http://patrickfrei.ch/webalizer/rb${PV/*_p/}/INSTALL"
	elog "if you are switching from stock webalizer to xtended"

	webapp_pkg_postinst
}
