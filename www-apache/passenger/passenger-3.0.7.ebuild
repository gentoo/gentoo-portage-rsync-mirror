# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/passenger/passenger-3.0.7.ebuild,v 1.6 2012/05/21 10:02:06 phajdan.jr Exp $

EAPI=2
USE_RUBY="ruby18"

inherit apache-module flag-o-matic ruby-ng

DESCRIPTION="Passenger (a.k.a. mod_rails) makes deployment of Ruby on Rails applications a breeze"
HOMEPAGE="http://modrails.com/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug doc"

ruby_add_rdepend "
	>=dev-ruby/daemon_controller-0.2.5
	>=dev-ruby/fastthread-1.0.1
	>=dev-ruby/rack-1.0.0"

CDEPEND=">=dev-libs/libev-3.90 net-misc/curl[ssl]"

RDEPEND="${RDEPEND} ${CDEPEND}"
DEPEND="${DEPEND} ${CDEPEND}
	doc? ( app-text/asciidoc[highlight] )"

APACHE2_MOD_CONF="30_mod_${PN}-2.0.1 30_mod_${PN}"
APACHE2_MOD_DEFINE="PASSENGER"

need_apache2_2

pkg_setup() {
	use debug && append-flags -DPASSENGER_DEBUG
}

all_ruby_prepare() {
	epatch "${FILESDIR}"/${PN}-3.0.0-gentoo.patch
	epatch "${FILESDIR}"/${PN}-3.0.0-ldflags.patch

	# Use sed here so that we can dynamically set the documentation directory.
	sed -i -e "s:/usr/share/doc/phusion-passenger:/usr/share/doc/${P}:" \
		-e "s:/usr/lib/apache2/modules/mod_passenger.so:${APACHE_MODULESDIR}/mod_passenger.so:" \
		-e "s:/usr/lib/phusion-passenger/agents:/usr/libexec/phusion-passenger/agents:" \
		lib/phusion_passenger.rb || die
	sed -i -e "s:/usr/lib/phusion-passenger/agents:/usr/libexec/phusion-passenger/agents:" ext/common/ResourceLocator.h || die

	# Don't install a tool that won't work in our setup.
	sed -i -e '/passenger-install-apache2-module/d' lib/phusion_passenger/packaging.rb || die
	rm -f bin/passenger-install-apache2-module || die "Unable to remove unneeded install script."

	# Make sure we use the system-provided version.
	rm -rf ext/libev || die "Unable to remove vendored libev."
}

each_ruby_compile() {
	append-flags -fno-strict-aliasing

	APXS2="${APXS}" \
	HTTPD="${APACHE_BIN}" \
	USE_VENDORED_LIBEV="no" LIBEV_LIBS="-lev" \
	rake apache2 native_support || die "rake failed"

	if use doc; then
		rake doc || die "rake doc failed"
	fi
}

each_ruby_install() {
	DISTDIR="${D}" \
	APXS2="${APXS}" \
	HTTPD="${APACHE_BIN}" \
	USE_VENDORED_LIBEV="no" LIBEV_LIBS="-lev" \
	rake fakeroot || die "rake failed"

	# TODO: this will create a mess when multiple RUBY_TARGETS have been
	# selected.
	APACHE2_MOD_FILE="${S}/ext/apache2/mod_${PN}.so"
	apache-module_src_install
}
