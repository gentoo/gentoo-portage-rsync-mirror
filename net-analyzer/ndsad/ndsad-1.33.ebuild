# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ndsad/ndsad-1.33.ebuild,v 1.8 2014/08/10 20:58:57 slyfox Exp $

inherit autotools

DESCRIPTION="Cisco netflow probe from libpcap, ULOG, tee/divert sources"
HOMEPAGE="http://sourceforge.net/projects/ndsad"
SRC_URI="mirror://sourceforge/ndsad/ndsad-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/libpcap-0.8"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Put ndsad binary in sbin.
	sed -i "s/bin_PROGRAMS = ndsad/sbin_PROGRAMS = ndsad/" Makefile.am || \
	die	"Can not change bin->sbin in Makefile.am... sed failed"

	sed -i \
	"s:^#define conf_path \"/netup/utm5/ndsad.cfg\":#define conf_path \"/etc/ndsad.conf\":" \
	ndsad.cc || die "Can not change default config path... sed failed"

	sed -i "s:log /tmp/ndsad.log:log /var/log/ndsad.log:" ndsad.conf || \
	die "Can not fix logging path in ndsad.conf... sed failed"

	eautoreconf
}

src_compile() {
	econf --with-ulog=yes
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	doman ndsad.conf.5 || die

	insinto /etc
	newins ndsad.conf ndsad.conf || die

	newinitd "${FILESDIR}"/ndsad.init ndsad || die
	newconfd "${FILESDIR}"/ndsad.conf.d ndsad || die

	dodoc ChangeLog AUTHORS README
}
