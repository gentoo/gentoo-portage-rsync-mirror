# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql++/mysql++-3.0.5.ebuild,v 1.2 2008/12/31 03:18:31 mr_bones_ Exp $

inherit eutils

DESCRIPTION="C++ API interface to the MySQL database"
HOMEPAGE="http://tangentsoft.net/mysql++/"
SRC_URI="http://www.tangentsoft.net/mysql++/releases/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/mysql-4.0"
DEPEND="${RDEPEND}
		>=sys-devel/gcc-3"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Not needed anymore, patch target is gone
	#epatch "${FILESDIR}"/${PN}-2.3.2-gcc-4.3.patch

	for i in "${S}"/lib/*.h ; do
		sed -i \
			-e '/#include </s,mysql.h,mysql/mysql.h,g' \
			-e '/#include </s,mysql_version.h,mysql/mysql_version.h,g' \
			"${i}" || die "Failed to sed ${i} for fixing MySQL includes"
	done
}

src_compile() {
	local myconf
	myconf="--enable-thread-check"

	CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
	econf ${myconf} || die "econf failed"

	emake || die "unable to make"
}

src_install() {
	emake DESTDIR="${D}" install || die
	# install the docs and HTML pages
	dodoc README* CREDITS* ChangeLog HACKERS Wishlist
	dodoc doc/*
	cp -ra doc/html "${D}"/usr/share/doc/${PF}/html
	prepalldocs
}
