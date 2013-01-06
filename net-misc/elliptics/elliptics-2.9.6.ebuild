# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/elliptics/elliptics-2.9.6.ebuild,v 1.3 2012/10/24 16:08:29 mr_bones_ Exp $

EAPI=4
PYTHON_DEPEND="2"

DESCRIPTION="Elliptics network is a fault tolerant key/value storage without dedicated metadata servers"
HOMEPAGE="http://www.ioremap.net/projects/elliptics"
LICENSE="GPL-2"
SLOT="0"

inherit eutils autotools python flag-o-matic

KEYWORDS="~x86 ~amd64"
IUSE="fastcgi python"
RDEPEND="dev-libs/openssl
        fastcgi? ( dev-libs/fcgi )
        net-misc/elliptics-eblob
        python? ( dev-libs/boost[python] )
        dev-libs/libevent
	dev-db/kyotocabinet"
#       dev-libs/libatomic
DEPEND="${RDEPEND}"

SRC_URI="http://www.ioremap.net/archive/${PN}/${P}.tar.gz"

pkg_setup() {
        enewgroup elliptics
        enewuser elliptics -1 -1 /dev/null elliptics
	python_set_active_version 2
	python_pkg_setup
}

src_prepare(){
        eautoreconf
}

src_configure(){
        use python && filter-ldflags -Wl,--as-needed
        econf \
                --with-libatomic-path=/dev/null \
                $(use_with python boost)
		--without-eblob
}

src_install(){
        emake install DESTDIR="${D}" || die
        use fastcgi && example/fcgi/lighttpd-fastcgi-elliptics.conf
        dodoc doc/design_notes.txt \
                doc/io_storage_backend.txt \
                example/EXAMPLE \
                example/ioserv.conf

        # init script stuff
        newinitd "${FILESDIR}"/elliptics.initd elliptics || die
        newconfd "${FILESDIR}"/elliptics.confd elliptics || die

        # tune default config
        sed -i 's#log = /dev/stderr#log = syslog#' ${S}/example/ioserv.conf
        sed -i 's#root = /tmp/root#root = /var/spool/elliptics#' ${S}/example/ioserv.conf
        sed -i 's#daemon = 0#daemon = 1#' ${S}/example/ioserv.conf
        sed -i 's#history = /tmp/history#history = /var/run/elliptics#' ${S}/example/ioserv.conf

        # configs
        insinto /etc/elliptics
        doins "${S}/example/ioserv.conf"

        keepdir /var/{spool,run}/elliptics
        fowners elliptics:elliptics /var/{spool,run}/elliptics
        fperms 0750 /var/{spool,run}/elliptics
}
