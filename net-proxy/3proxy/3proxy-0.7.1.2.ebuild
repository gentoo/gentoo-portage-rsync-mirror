# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
inherit eutils

DESCRIPTION="3Proxy is really tiny cross-platform proxy servers set"
HOMEPAGE="http://www.3proxy.ru/"
SRC_URI="http://3proxy.ru/${PVR}/${P}.tgz"
LICENSE="GPL3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
        cp "${S}"/Makefile.Linux "${S}"/Makefile
        epatch "${FILESDIR}"/"${PN}"-Makefile.patch || die "epatch failed"
	sed -i -e 's:/usr/local::' src/stringtable.c
}

src_install() {
        local x

        pushd src
        dobin 3proxy || die "dobin 3proxy failed"
        for x in proxy socks ftppr pop3p tcppm udppm mycrypt dighosts countersutil ; do
                newbin ${x} ${PN}-${x} || die "newbin ${x} failed"
                [[ -f ${S}/man/${x}.8 ]] \
                        && newman "${S}"/man/${x}.8 ${PN}-${x}.8
        done
        popd

        doman "${S}"/man/3proxy*.[38]

}

