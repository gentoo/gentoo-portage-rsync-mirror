# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rigo-daemon/rigo-daemon-216.ebuild,v 1.1 2013/08/22 11:13:59 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python

MY_PN="RigoDaemon"
DESCRIPTION="Entropy Client DBus Services, aka RigoDaemon"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"

S="${WORKDIR}/entropy-${PV}/rigo/${MY_PN}"

DEPEND=""
RDEPEND="dev-python/dbus-python
	dev-python/pygobject:3
	~sys-apps/entropy-${PV}
	sys-auth/polkit[introspection]
	sys-devel/gettext"

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

pkg_preinst() {
	# ask RigoDaemon to shutdown, if running
	# TODO: this will be removed in future
	local shutdown_exec=${EROOT}/usr/lib/rigo/${MY_PN}/shutdown.py
	[[ -x "${shutdown_exec}" ]] && "${shutdown_exec}"
}

pkg_postinst() {
	python_mod_optimize "/usr/lib/rigo/${MY_PN}"
}

pkg_postrm() {
	python_mod_cleanup "/usr/lib/rigo/${MY_PN}"
}
