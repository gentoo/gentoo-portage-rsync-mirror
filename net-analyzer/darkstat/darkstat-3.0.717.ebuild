# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/darkstat/darkstat-3.0.717.ebuild,v 1.1 2013/08/26 08:05:12 pinkbyte Exp $

EAPI=5

inherit eutils user

DESCRIPTION="darkstat is a network traffic analyzer"
HOMEPAGE="http://unix4lyfe.org/darkstat/"
SRC_URI="http://unix4lyfe.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

DARKSTAT_CHROOT_DIR=${DARKSTAT_CHROOT_DIR:-/var/lib/darkstat}
DOCS=( AUTHORS ChangeLog README NEWS )

src_prepare() {
	epatch_user
}

src_configure() {
	econf \
		--with-privdrop-user=darkstat \
		--with-chroot-dir="${DARKSTAT_CHROOT_DIR}"
}

src_install() {
	default

	newinitd "${FILESDIR}"/darkstat-init.new darkstat
	newconfd "${FILESDIR}"/darkstat-confd.new darkstat

	sed -i -e "s:__CHROOT__:${DARKSTAT_CHROOT_DIR}:g" "${D}"/etc/conf.d/darkstat
	sed -i -e "s:__CHROOT__:${DARKSTAT_CHROOT_DIR}:g" "${D}"/etc/init.d/darkstat

	keepdir "${DARKSTAT_CHROOT_DIR}"
	chown darkstat:0 "${D}${DARKSTAT_CHROOT_DIR}"
}

pkg_preinst() {
	enewuser darkstat
}

pkg_postinst() {
	# Workaround bug #141619
	DARKSTAT_CHROOT_DIR=`sed -n 's/^#CHROOT=\(.*\)/\1/p' "${ROOT}"etc/conf.d/darkstat`
	chown darkstat:0 "${ROOT}${DARKSTAT_CHROOT_DIR}"

	elog "To start different darkstat instances which will listen on a different"
	elog "interfaces create in /etc/init.d directory the 'darkstat.if' symlink to"
	elog "darkstat script where 'if' is the name of the interface."
	elog "Also in /etc/conf.d directory copy darkstat to darkstat.if"
	elog "and edit it to change default values."
	elog
	elog "darkstat's default chroot directory is: \"${ROOT}${DARKSTAT_CHROOT_DIR}\""
}
