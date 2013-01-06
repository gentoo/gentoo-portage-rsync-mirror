# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/freeipmi/freeipmi-1.1.7.ebuild,v 1.3 2012/08/26 13:36:34 idl0r Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Provides Remote-Console and System Management Software as per IPMI v1.5/2.0"
HOMEPAGE="http://www.gnu.org/software/freeipmi/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	http://ftp.gluster.com/pub/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="dev-libs/libgcrypt"
DEPEND="${RDEPEND}
		virtual/os-headers"
RDEPEND="${RDEPEND}
	sys-apps/openrc"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.1.1-strictaliasing.patch \
		"${FILESDIR}"/${PN}-1.1.6-thresholds.patch

	AT_M4DIR="config" eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		--disable-dependency-tracking \
		--enable-fast-install \
		--disable-static \
		--disable-init-scripts \
		--enable-logrotate-config \
		--localstatedir=/var
}

# There are no tests
src_test() { :; }

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install
	find "${D}" -name '*.la' -delete

	# freeipmi by defaults install _all_ commands to /usr/sbin, but
	# quite a few can be run remotely as standard user, so move them
	# in /usr/bin afterwards.
	dodir /usr/bin
	for file in ipmi{detect,ping,power,console}; do
		mv "${D}"/usr/{s,}bin/${file} || die

		# The default install symlinks these commands to add a dash
		# after the ipmi prefix; we repeat those after move for
		# consistency.
		rm "${D}"/usr/sbin/${file/ipmi/ipmi-}
		dosym ${file} /usr/bin/${file/ipmi/ipmi-}
	done

	dodoc AUTHORS ChangeLog* DISCLAIMER* NEWS README* TODO doc/*.txt

	keepdir \
		/var/cache/ipmimonitoringsdrcache \
		/var/lib/freeipmi \
		/var/log/{freeipmi,ipmiconsole}

	newinitd "${FILESDIR}"/ipmidetectd.initd.3 ipmidetectd

	newinitd "${FILESDIR}"/bmc-watchdog.initd.3 bmc-watchdog
	newconfd "${FILESDIR}"/bmc-watchdog.confd bmc-watchdog
}
