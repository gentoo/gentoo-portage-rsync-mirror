# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/axtls/axtls-1.4.9.ebuild,v 1.8 2013/02/21 16:36:38 jer Exp $

EAPI="4"

inherit eutils multilib savedconfig toolchain-funcs user

################################################################################
# axtls CONFIG MINI-HOWTO
#
# Note: axtls is highly configurable and uses mconf, like the linux kernel.
# You can configure it in a couple of ways:
#
# 1) USE="-savedconfig" and set/unset the remaining flags to obtain the features
# you want, and possibly a lot more.
#
# 2) You can create your own configuration file by doing
#
#	FEATURES="keepwork" USE="savedconfig -*" emerge axtls
#	cd /var/tmp/portage/net-libs/axtls*/work/axTLS
#	make menuconfig
#
# Now configure axtls as you want.  Finally save your config file:
#
#	cp config/.config /etc/portage/savedconfig/net-libs/axtls-${PV}
#
# where ${PV} is the current version.  You can then run emerge again with
# your configuration by doing
#
#	USE="savedconfig" emerge axtls
#
################################################################################

MY_PN=${PN/tls/TLS}

DESCRIPTION="Embedded client/server TLSv1 SSL library and small HTTP(S) server"
HOMEPAGE="http://axtls.sourceforge.net/"
SRC_URI="mirror://sourceforge/axtls/${MY_PN}-${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ~mips ppc ppc64 x86"

IUSE="httpd cgi-lua cgi-php static static-libs doc"

# TODO: add ipv6, and c#, java, lua, perl bindings
# Currently these all have some issue
DEPEND="doc? ( app-doc/doxygen )"
RDEPEND="
	httpd? (
		cgi-lua? ( dev-lang/lua )
		cgi-php? ( dev-lang/php[cgi] )
	)"

#Note1: static, cgi-* makes no sense if httpd is not given
REQUIRED_USE="
	static? ( httpd )
	cgi-lua? ( httpd )
	cgi-php? ( httpd )"

AXTLS_GROUP="axtls"
AXTLS_USER="axtls"

pkg_setup() {
	use httpd && {
		ebegin "Creating axtls user and group"
		enewgroup ${AXTLS_GROUP}
		enewuser ${AXTLS_USER} -1 -1 -1 ${AXTLS_GROUP}
	}
}

src_prepare() {
	tc-export CC

	epatch "${FILESDIR}/explicit-libdir.patch"

	sed -i -e 's:^LIBDIR.*/lib:LIBDIR = $(PREFIX)/'"$(get_libdir):" \
		"${S}"/Makefile

	#Use CC as the host compiler for mconf
	sed -i -e "s:^HOSTCC.*:HOSTCC=${CC}:" \
		"${S}"/config/Rules.mak

	#We want CONFIG_DEBUG to avoid stripping
	#but not for debugging info
	sed -i -e 's: -g::' \
		"${S}"/config/Rules.mak
	sed -i -e 's: -g::' \
		"${S}"/config/makefile.conf
}

use_flag_config() {
	cp "${FILESDIR}"/config "${S}"/config/.config

	#Respect CFLAGS/LDFLAGS
	sed -i -e "s:^CONFIG_EXTRA_CFLAGS_OPTIONS.*$:CONFIG_EXTRA_CFLAGS_OPTIONS=\"${CFLAGS}\":" \
		"${S}"/config/.config
	sed -i -e "s:^CONFIG_EXTRA_LDFLAGS_OPTIONS.*$:CONFIG_EXTRA_LDFLAGS_OPTIONS=\"${LDLAGS}\":" \
		"${S}"/config/.config

	#The logic is that the default config file enables everything and we disable
	#here with sed unless a USE flags says to keep it
	if use httpd; then
		if ! use static; then
			sed -i -e 's:^CONFIG_HTTP_STATIC_BUILD:# CONFIG_HTTP_STATIC_BUILD:' \
				"${S}"/config/.config
		fi
		if ! use cgi-php && ! use cgi-lua; then
			sed -i -e 's:^CONFIG_HTTP_HAS_CGI:# CONFIG_HTTP_HAS_CGI:' \
				"${S}"/config/.config
		fi
		if ! use cgi-php; then
			sed -i -e 's:,.php::' "${S}"/config/.config
		fi
		if ! use cgi-lua; then
			sed -i -e 's:\.lua,::' \
				-e 's:lua:php:' \
				-e 's:^CONFIG_HTTP_ENABLE_LUA:# CONFIG_HTTP_ENABLE_LUA:' \
				"${S}"/config/.config
		fi
	else
		sed -i -e 's:^CONFIG_AXHTTPD:# CONFIG_AXHTTPD:' \
			"${S}"/config/.config
	fi

	yes "n" | emake -j1 oldconfig > /dev/null
}

src_configure() {
	tc-export CC
	tc-export AR

	if use savedconfig; then
		restore_config config/.config
		if [ -f config/.config ]; then
			ewarn "Using saved config, all other USE flags ignored"
		else
			ewarn "No saved config, seeding with the default"
			cp "${FILESDIR}"/config "${S}"/config/.config
		fi
		yes "" | emake -j1 oldconfig > /dev/null
	else
		use_flag_config
	fi
}

src_compile() {
	default
	use doc && emake docs
}

src_install() {
	if use savedconfig; then
		save_config config/.config
	fi

	emake PREFIX="${ED}/usr" install

	if ! use static-libs; then
		rm -f "${ED}"/usr/$(get_libdir)/libaxtls.a
	fi

	if [ -f "${ED}"/usr/bin/htpasswd ]; then
		mv "${ED}"/usr/bin/{,ax}htpasswd
	fi

	if use httpd; then
		newinitd "${FILESDIR}"/axhttpd.initd axhttpd
		newconfd "${FILESDIR}"/axhttpd.confd axhttpd
	fi

	docompress -x /usr/share/doc/${PF}/README
	dodoc -r README

	if use doc; then
		dodoc -r docsrc/html
	fi
}
