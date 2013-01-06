# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-5.39.1.ebuild,v 1.8 2010/12/17 15:33:07 flameeyes Exp $

EAPI="2"

inherit flag-o-matic
if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://smartmontools.svn.sourceforge.net/svnroot/smartmontools/trunk/smartmontools"
	ESVN_PROJECT="smartmontools"
	inherit subversion autotools
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="alpha amd64 ~arm hppa ia64 ppc sparc x86 ~x86-fbsd"
fi

DESCRIPTION="Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.) monitoring tools"
HOMEPAGE="http://smartmontools.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="static minimal"

RDEPEND="!minimal? ( virtual/mailx )"
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
	use minimal && einfo "Skipping the monitoring daemon for minimal build."
	use static && append-ldflags -static
	econf \
		--with-docdir="/usr/share/doc/${PF}" \
		--with-initscriptdir="/toss-it-away" \
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
