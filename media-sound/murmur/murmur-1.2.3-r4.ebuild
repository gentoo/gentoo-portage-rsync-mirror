# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/murmur/murmur-1.2.3-r4.ebuild,v 1.1 2012/12/31 09:52:43 polynomial-c Exp $

EAPI="4"

inherit eutils qt4-r2 user

MY_P="${PN/murmur/mumble}-${PV/_/~}"

DESCRIPTION="Mumble is an open source, low-latency, high quality voice chat software"
HOMEPAGE="http://mumble.sourceforge.net/"
SRC_URI="mirror://sourceforge/mumble/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 x86"
IUSE="+dbus debug +ice pch zeroconf"

RDEPEND=">=dev-libs/openssl-1.0.0b
	>=dev-libs/protobuf-2.2.0
	sys-apps/lsb-release
	>=sys-libs/libcap-2.15
	x11-libs/qt-core:4[ssl]
	|| ( x11-libs/qt-sql:4[sqlite] x11-libs/qt-sql:4[mysql] )
	x11-libs/qt-xmlpatterns:4
	dbus? ( x11-libs/qt-dbus:4 )
	ice? ( dev-libs/Ice )
	zeroconf? ( net-dns/avahi[mdnsresponder-compat] )"

DEPEND="${RDEPEND}
	>=dev-libs/boost-1.41.0
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.2.3-ice-3.4.2-compat.patch
	"${FILESDIR}"/mumble-1.2.3-remove-certs.patch
	"${FILESDIR}"/mumble-1.2.3-fix-cert-validation.patch
)

pkg_setup() {
	enewgroup murmur
	enewuser murmur -1 -1 /var/lib/murmur murmur
}

src_prepare() {
	qt4-r2_src_prepare

	sed -i -e 's:mumble-server:murmur:g' \
		"${S}"/scripts/murmur.{conf,ini.system} || die
}

src_configure() {
	local conf_add

	use dbus || conf_add="${conf_add} no-dbus"
	use debug && conf_add="${conf_add} symbols debug" || conf_add="${conf_add} release"
	use ice || conf_add="${conf_add} no-ice"
	use pch || conf_add="${conf_add} no-pch"
	use zeroconf || conf_add="${conf_add} no-bonjour"

	eqmake4 main.pro -recursive \
		CONFIG+="${conf_add} no-client"
}

src_compile() {
	# parallel make workaround, upstream bug #3190498
	emake -j1
}

src_install() {
	dodoc README CHANGES

	docinto scripts
	dodoc scripts/*.php scripts/*.pl

	local dir
	if use debug; then
		dir=debug
	else
		dir=release
	fi

	dobin "${dir}"/murmurd

	insinto /etc/murmur/
	newins scripts/murmur.ini.system murmur.ini

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/murmur.logrotate murmur

	insinto /etc/dbus-1/system.d/
	doins scripts/murmur.conf

	insinto /usr/share/murmur/
	doins src/murmur/Murmur.ice

	newinitd "${FILESDIR}"/murmur.initd murmur
	newconfd "${FILESDIR}"/murmur.confd murmur

	keepdir /var/lib/murmur /var/run/murmur /var/log/murmur
	fowners -R murmur /var/lib/murmur /var/run/murmur /var/log/murmur
	fperms 750 /var/lib/murmur /var/run/murmur /var/log/murmur

	doman man/murmurd.1
}

pkg_postinst() {
	echo
	elog "Useful scripts are located in /usr/share/doc/${PF}/scripts."
	elog "Please execute:"
	elog "murmurd -ini /etc/murmur/murmur.ini -supw <pw>"
	elog "chown murmur:murmur /var/lib/murmur/murmur.sqlite"
	elog "to set the build-in 'SuperUser' password before starting murmur."
	elog "Please restart dbus before starting murmur, or else dbus"
	elog "registration will fail."
	echo
}
