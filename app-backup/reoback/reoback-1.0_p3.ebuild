# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/reoback/reoback-1.0_p3.ebuild,v 1.4 2006/10/15 19:09:28 dertobi123 Exp $

DESCRIPTION="Reoback Backup Solution"
HOMEPAGE="http://reoback.sourceforge.net/"
SRC_URI="mirror://sourceforge/reoback/reoback-${PV/_p/_r}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1"
DEPEND=">=app-arch/tar-1.13"

S=${WORKDIR}/${PN}-${PV/_*}

src_unpack() {
	unpack ${A}
	find . -name CVS -type d | xargs rm -r
	cd "${S}"
	sed -i \
		-e '/^config=/s:=.*:=/etc/reoback/settings.conf:' \
		-e '/^reoback=/s:=.*:=/usr/sbin/reoback.pl:' \
		run_reoback.sh || die
}

src_install() {
	dosbin reoback.pl || die "dosbin"
	insinto /etc/reoback
	doins conf/* || die "doins conf"
	fperms 750 /usr/sbin/reoback.pl
	insinto /etc/cron.daily
	doins run_reoback.sh
	cd docs
	dodoc BUGS CHANGES INSTALL MANUALS README TODO
}
