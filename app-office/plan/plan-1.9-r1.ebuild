# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/plan/plan-1.9-r1.ebuild,v 1.5 2013/10/12 21:03:58 pacho Exp $

EAPI=1

inherit eutils

DESCRIPTION="Motif based schedule planner"
HOMEPAGE="http://www.bitrot.de/plan.html"
SRC_URI="ftp://ftp.fu-berlin.de/unix/X11/apps/plan/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.tar.bz2"

LICENSE="GPL-2+" #448646
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND="
	x11-libs/libXpm
	>=x11-libs/motif-2.3:0
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/${P}-errno.patch
	epatch "${WORKDIR}"/${P}-gentoo.patch
	epatch "${WORKDIR}"/${P}-webplan.patch
	epatch "${FILESDIR}"/makefile.patch
	epatch "${FILESDIR}"/nostrip.patch
	epatch "${FILESDIR}"/ldflags.patch
}

src_compile() {
	emake CC=$(tc-getCC) SHARE=/usr/share/plan linux || die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		SHARE=/usr/share/plan \
		install || die "install failed"
	keepdir /usr/share/plan/netplan.dir

	cd "${S}"/..
	dodoc HISTORY README || die "dodoc failed"

	cd "${S}"/../misc
	doman netplan.1 plan.1 plan.4 || die "doman failed"

	insinto /usr/share/${PN}/misc
	doins netplan.boot BlackWhite Monochrome plan.fti Plan.xpm plan.xpm \
		|| die "misc files install failed"
	exeinto /usr/share/${PN}/misc
	doexe Killpland cvs vsc msschedule2plan plan2vcs || die "misc files install failed"

	cd "${S}"/../web
	insinto /usr/share/${PN}/web
	doins help.html bottom.html cgi-lib.pl common.pl holiday_webplan rtsban.jpg \
		|| die "webplan install failed"
	exeinto /usr/share/${PN}/web
	doexe *.cgi || die "webplan install failed"
}

pkg_postinst() {
	elog
	elog " Check /usr/share/${PN}/holiday for examples to set your"
	elog " ~/.holiday according to your country."
	elog
	elog " WebPlan ${PV} can be found in /usr/share/${PN}/web."
	elog
}
