# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwknop/fwknop-2.6.2.ebuild,v 1.1 2014/05/28 16:17:58 swift Exp $

EAPI=5

# does work with python 2.7, doesn't work with python 3.3 on my machine
# more feedback is welcome
PYTHON_COMPAT=( python2_7 )
DISTUTILS_OPTIONAL=1
inherit autotools distutils-r1 eutils systemd

DESCRIPTION="Single Packet Authorization and Port Knocking application"
HOMEPAGE="http://www.cipherdyne.org/fwknop/"
SRC_URI="http://www.cipherdyne.org/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="client extras gdbm gpg python server"

RDEPEND="python? ( ${PYTHON_DEPS} )
	gpg? (
		dev-libs/libassuan
		dev-libs/libgpg-error
	)
"
DEPEND="${RDEPEND}
	gdbm? ( sys-libs/gdbm )
	gpg? ( app-crypt/gpgme )
	server? (
		net-libs/libpcap
		net-firewall/iptables
	)
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DOCS=( ChangeLog README )

src_prepare() {
	# Remove extra run/ subdir from localstatedir paths
	#
	# fwknopd's default location for digest-cache and pidfile is
	# localstatedir/run/fwknop (see server/fwknopd_common.h).
	# Such files (cache, pidfile) should be placed in /run/fwknop instead.
	# fwknopd's default apparmor policy also assumes that these files are in
	# /run/fwknop, i.e. localstatedir is /var and /var/run is a symlink to /run.
	# Relying on /var/run -> /run symlink is not the best practice.
	# This is why simply binding localstatedir to /var is not enough.
	# Instead we strip hardcoded run/ subdir from localstatedir paths
	# ans set localstatedir to /run below.
	epatch "${FILESDIR}/fwknop-2.6.0-remove-extra-run-from-paths.patch"

	# Install example configs with .example suffix
	if use server; then
		sed -i 's/conf;/conf.example;/g' "${S}"/Makefile.am || die
	fi
	eautoreconf

	use python && distutils-r1_src_prepare
}

src_configure() {
	econf \
		--localstatedir=/run \
		--enable-digest-cache \
		$(use_enable client) \
		$(use_enable !gdbm file-cache) \
		$(use_enable server) \
		$(use_with gpg gpgme)
}

src_compile() {
	default

	if use python; then
		cd "${S}"/python || die
		distutils-r1_src_compile
	fi
}

src_install() {
	default

	if use server; then
		newinitd "${FILESDIR}/fwknopd.init" fwknopd
		newconfd "${FILESDIR}/fwknopd.confd" fwknopd
		systemd_newtmpfilesd "${FILESDIR}/fwknopd.tmpfiles.conf" fwknopd.conf
	fi

	use extras && dodoc "${S}/extras/apparmor/usr.sbin.fwknopd"

	if use python; then
		# Unset DOCS since distutils-r1.eclass interferes
		DOCS=()
		cd "${S}"/python || die
		distutils-r1_src_install
	fi
}
