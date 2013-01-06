# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gorg/gorg-0.6.5.ebuild,v 1.1 2012/10/26 11:51:59 graaff Exp $

EAPI=4
USE_RUBY="ruby18"

inherit ruby-ng eutils

DESCRIPTION="Back-end XSLT processor for an XML-based web site"
HOMEPAGE="http://www.gentoo.org/proj/en/gdp/doc/gorg.xml"
SRC_URI="https://github.com/gentoo/gorg/tarball/${PV} -> ${P}-git.tgz"
IUSE="fastcgi mysql"

RUBY_S="gentoo-gorg-*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

CDEPEND="
	>=dev-libs/libxml2-2.6.16
	>=dev-libs/libxslt-1.1.12"
DEPEND="${DEPEND} ${CDEPEND}"
RDEPEND="${RDEPEND} ${CDEPEND}
		fastcgi? ( virtual/httpd-fastcgi )"

ruby_add_rdepend "
	mysql? ( >=dev-ruby/dbi-0.0.21[mysql] )
	fastcgi? ( >=dev-ruby/fcgi-0.8.5-r1 )"

pkg_setup() {
	enewgroup gorg
	enewuser  gorg -1 -1 -1 gorg
}

each_ruby_configure() {
	${RUBY} setup.rb config --prefix=/usr || die
}

each_ruby_compile() {
	${RUBY} setup.rb setup || die
}

each_ruby_install() {
	${RUBY} setup.rb config --prefix="${D}"/usr || die
	${RUBY} setup.rb install                    || die

	# install doesn't seem to chmod these correctly, forcing it here
	SITE_LIB_DIR=$(ruby_rbconfig_value 'sitelibdir')
	chmod +x "${D}"/${SITE_LIB_DIR}/gorg/cgi-bin/*.cgi
	chmod +x "${D}"/${SITE_LIB_DIR}/gorg/fcgi-bin/*.fcgi
}

all_ruby_install() {
	keepdir /etc/gorg; insinto /etc/gorg ; doins etc/gorg/*
	diropts -m0770 -o gorg -g gorg; keepdir /var/cache/gorg

	dodoc Changelog README
}
