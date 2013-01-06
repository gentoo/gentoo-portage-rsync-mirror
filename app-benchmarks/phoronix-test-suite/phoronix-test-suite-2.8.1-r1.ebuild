# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/phoronix-test-suite/phoronix-test-suite-2.8.1-r1.ebuild,v 1.4 2011/12/14 22:55:55 mabi Exp $

EAPI=4

inherit eutils

DESCRIPTION="Phoronix's comprehensive, cross-platform testing and benchmark suite"
HOMEPAGE="http://www.phoronix-test-suite.com"
SRC_URI="http://www.phoronix-test-suite.com/download.php?file=${P} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

# php 5.3 doesn't have pcre useflag anymore
RDEPEND=">=dev-lang/php-5.2[cli,curl,gd,posix,pcntl,pcre(+),truetype]
		app-arch/unzip
		dev-php/pecl-ps"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/font.patch
	sed -i -e "s,export PTS_DIR=\`pwd\`,export PTS_DIR=\"/usr/share/${PN}\"," \
		phoronix-test-suite
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r {pts,pts-core}

	doman documentation/man-pages/phoronix-test-suite.1
	dodoc AUTHORS CHANGE-LOG
	dohtml README.html

	exeinto /usr/bin
	doexe phoronix-test-suite

	# this is horribly ugly because fperms uses absolute relative paths, so we have one ${D} wrongly added in
	# ... so we use parameter expansion to remove it, and add a trailing slash because argh noooes
	for i in  ${D}usr/share/${PN}/pts/test-resources/*/*.sh ${D}/usr/share/${PN}/pts/base-test-resources/*/*.sh ${D}/usr/share/${PN}/pts-core/test-libraries/*.sh; do
		fperms a+x /${i#${D}}
	done

	# Need to fix the cli-php config for downloading to work. Very naughty!
	dodir /etc/php/cli-php5
	cp /etc/php/cli-php5/php.ini "${D}/etc/php/cli-php5/php.ini"
	sed -e 's|^allow_url_fopen .*|allow_url_fopen = On|g' -i "${D}/etc/php/cli-php5/php.ini"
}
