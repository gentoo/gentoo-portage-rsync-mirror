# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gpgme/gpgme-2.0.8.ebuild,v 1.2 2015/02/12 05:22:58 patrick Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-ng ruby-fakegem flag-o-matic

DESCRIPTION="Ruby language binding for GnuPG Made Easy"
HOMEPAGE="https://github.com/ueno/ruby-gpgme"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND='>=app-crypt/gpgme-1.1.2'
RDEPEND="${DEPEND}"

each_ruby_configure() {
	append-flags -fPIC
	export RUBY_GPGME_USE_SYSTEM_LIBRARIES=1
	${RUBY} -C ext "${S}/ext/gpgme/extconf.rb" || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -C ext archflag="${LDFLAGS}" || die "emake failed"
	cp -f "${S}/ext/gpgme_n.so" "${S}/lib" || die
}
