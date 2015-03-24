# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/galera/galera-25.3.10.ebuild,v 1.1 2015/03/24 18:32:11 grknight Exp $

EAPI=5

inherit scons-utils multilib toolchain-funcs eutils user

MY_PV="release_${PV}"
DESCRIPTION="Synchronous multi-master replication engine that provides its service through wsrep API"
HOMEPAGE="http://www.galeracluster.com/"
SRC_URI="https://github.com/codership/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2 BSD"

SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="garbd ssl test"

CDEPEND="
	 ssl? ( dev-libs/openssl:0= )
	>=dev-libs/boost-1.41:0=
	"
DEPEND="${DEPEND}
	${CDEPEND}
	dev-libs/check
	>=sys-devel/gcc-4.4
	>=dev-cpp/asio-1.4.8[ssl?]
	"
#Run time only
RDEPEND="${CDEPEND}
	garbd? ( || (
		net-analyzer/netcat
		net-analyzer/netcat6
		net-analyzer/gnu-netcat
		net-analyzer/openbsd-netcat
	) )"

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_preinst() {
	if use garbd ; then
		enewgroup garbd
		enewuser garbd -1 -1 -1 garbd
	fi
}

src_prepare() {
	# Remove bundled dev-cpp/asio
	rm -r "${S}/asio" || die

	# Respect {C,LD}FLAGS.
	epatch "${FILESDIR}/respect-flags.patch"

	#Remove optional garbd daemon
	if ! use garbd ; then
		rm -r "${S}/garb" || die
	fi

	epatch_user
}

src_configure() {
	tc-export CC CXX
	# strict_build_flags=0 disables -Werror, -pedantic, -Weffc++,
	# and -Wold-style-cast
	myesconsargs=(
		$(use_scons ssl ssl 1 0)
		$(use_scons test tests 1 0)
		strict_build_flags=0
	)
}

src_compile() {
	escons --warn=no-missing-sconscript
}

src_install() {
	dodoc scripts/packages/README scripts/packages/README-MySQL
	if use garbd ; then
		dobin garb/garbd
		newconfd "${FILESDIR}/garb.cnf" garbd
		newinitd "${FILESDIR}/garb.sh" garbd
		doman man/garbd.8
	fi
	exeinto /usr/$(get_libdir)/${PN}
	doexe libgalera_smm.so
}
