# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-7.5.ebuild,v 1.4 2014/12/28 16:04:54 titanofold Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/thc-hydra/"
SRC_URI="http://freeworld.thc.org/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="firebird gtk idn mysql ncp oracle pcre postgres ssl subversion"

RDEPEND="
	dev-libs/openssl
	firebird? ( dev-db/firebird )
	gtk? (
		dev-libs/atk
		dev-libs/glib:2
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:2
	)
	idn? ( net-dns/libidn )
	mysql? ( virtual/mysql )
	ncp? ( net-fs/ncpfs )
	oracle? ( dev-db/oracle-instantclient-basic )
	pcre? ( dev-libs/libpcre )
	postgres? ( dev-db/postgresql )
	ssl? ( >=net-libs/libssh-0.4.0 )
	subversion? ( dev-vcs/subversion )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	# None of the settings in Makefile.unix are useful to us
	: > Makefile.unix

	sed -i \
		-e 's:|| echo.*$::' \
		-e '/\t-$(CC)/s:-::' \
		-e '/^OPTS/{s|=|+=|;s| -O3||}' \
		-e '/ -o /s:$(OPTS):& $(LDFLAGS):g' \
		Makefile.am || die "sed failed"
}

src_configure() {
	# Note: despite the naming convention, the top level script is not an
	# autoconf-based script.
	export OPTS="${CFLAGS}"
	if ! use subversion; then
		einfo "Disabling Subversion support..."
		sed -i 's/-lsvn_client-1 -lapr-1 -laprutil-1 -lsvn_subr-1//;s/-DLIBSVN//' configure || die "Could not disable Subversion"
	fi
	if ! use mysql; then
		einfo "Disabling MYSQL support..."
		sed -i 's/-lmysqlclient//;s/-DLIBMYSQLCLIENT//' configure || die "Could not disable MYSQL"
	fi
	./configure \
		--prefix=/usr \
		--nostrip \
		$(use gtk && echo --disable-xhydra) \
			|| die "configure failed"

# It looks like all of these could be superfluous - reenable as needed
#	sed -i \
#		-e '/^XDEFINES=/s:=.*:=:' \
#		-e '/^XLIBS=/s:=.*:=-lcrypto:' \
#		-e '/^XLIBPATHS/s:=.*:=:' \
#		-e '/^XIPATHS=/s:=.*:=:' \
#		Makefile || die "pruning vars"

#	if use ssl ; then
#		sed -i \
#			-e '/^XDEFINES=/s:=:=-DLIBOPENSSLNEW -DLIBSSH:' \
#			-e '/^XLIBS=/s:$: -lssl -lssh:' \
#			Makefile || die "adding ssl"
#	fi

	if use gtk ; then
		cd hydra-gtk && \
		econf || die "econf failed"
	fi
}

src_compile() {
	tc-export CC
	emake
	if use gtk ; then
		cd hydra-gtk && \
		emake
	fi
}

src_install() {
	dobin hydra pw-inspector
	if use gtk ; then
		dobin hydra-gtk/src/xhydra
	fi
	dodoc CHANGES README
}
