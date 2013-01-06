# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-5.40.ebuild,v 1.9 2011/02/08 18:49:05 xarthisius Exp $

EAPI="2"

inherit flag-o-matic
if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://smartmontools.svn.sourceforge.net/svnroot/smartmontools/trunk/smartmontools"
	ESVN_PROJECT="smartmontools"
	inherit subversion autotools
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
fi

DESCRIPTION="Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.) monitoring tools"
HOMEPAGE="http://smartmontools.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="static minimal caps"

RDEPEND="!minimal? (
		virtual/mailx
		caps? ( sys-libs/libcap-ng )
	)"
DEPEND=""

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
	fi
}

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		#./autogen.sh
		eautoreconf
	fi
}

src_configure() {
	local myconf
	use minimal && einfo "Skipping the monitoring daemon for minimal build."
	use static && append-ldflags -static

	if ! use minimal; then
		myconf="${myconf} $(use_with caps libcap-ng)"
	else
		# disable it so that we stay safe
		myconf="${myconf} --without-libcap-ng"
	fi

	econf \
		--with-docdir="/usr/share/doc/${PF}" \
		--with-initscriptdir="/toss-it-away" \
		${myconf} \
		|| die
}

src_install() {
	if use minimal ; then
		dosbin smartctl || die
		doman smartctl.8
	else
		emake install DESTDIR="${D}" || die
		rm -rf "${D}"/toss-it-away
		newinitd "${FILESDIR}"/smartd.rc smartd
		newconfd "${FILESDIR}"/smartd.confd smartd
	fi
}
