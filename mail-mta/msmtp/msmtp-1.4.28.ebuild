# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.4.28.ebuild,v 1.9 2012/11/06 11:16:40 eras Exp $

EAPI=4
inherit multilib python

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/msmtp/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc gnome-keyring gnutls idn +mta nls sasl ssl vim-syntax"

CDEPEND="
	gnome-keyring? (
		dev-python/gnome-keyring-python
		gnome-base/libgnome-keyring
	)
	idn? ( net-dns/libidn )
	nls? ( virtual/libintl )
	sasl? ( virtual/gsasl )
	ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( dev-libs/openssl )
	)"

RDEPEND="${CDEPEND}
	net-mail/mailbase
	mta? (	!mail-mta/courier
			!mail-mta/esmtp
			!mail-mta/exim
			!mail-mta/mini-qmail
			!mail-mta/netqmail
			!mail-mta/nullmailer
			!mail-mta/postfix
			!mail-mta/qmail-ldap
			!mail-mta/sendmail
			!<mail-mta/ssmtp-2.64-r2
			!>=mail-mta/ssmtp-2.64-r2[mta] )"

DEPEND="${CDEPEND}
	doc? ( virtual/texi2dvi )
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

REQUIRED_USE="gnutls? ( ssl )"

src_prepare() {
	# Use default Gentoo location for mail aliases
	sed -i -e 's:/etc/aliases:/etc/mail/aliases:' scripts/find_alias/find_alias_for_msmtp.sh || die

	python_convert_shebangs 2 scripts/msmtp-gnome-tool/msmtp-gnome-tool.py
}

src_configure() {
	econf \
		$(use_with gnome-keyring ) \
		$(use_with idn libidn) \
		$(use_enable nls) \
		$(use_with sasl libgsasl) \
		$(use_with ssl ssl $(use gnutls && echo "gnutls" || echo "openssl"))
}

src_compile() {
	default

	if use doc ; then
		cd doc || die
		emake html pdf
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README THANKS doc/{Mutt+msmtp.txt,msmtprc*}

	if use doc ; then
		dohtml doc/msmtp.html
		dodoc doc/msmtp.pdf
	fi

	if use gnome-keyring ; then
		src_install_contrib msmtp-gnome-tool msmtp-gnome-tool.py README
	fi

	if use mta ; then
		dodir /usr/sbin
		dosym /usr/bin/msmtp /usr/sbin/sendmail
		dosym /usr/bin/msmtp /usr/$(get_libdir)/sendmail
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/syntax
		doins scripts/vim/msmtp.vim
	fi

	src_install_contrib find_alias find_alias_for_msmtp.sh
	src_install_contrib msmtpqueue "*.sh" "README ChangeLog"
	src_install_contrib msmtpq "msmtpq msmtp-queue" README.msmtpq
	src_install_contrib set_sendmail set_sendmail.sh set_sendmail.conf
}

src_install_contrib() {
	subdir="$1"
	bins="$2"
	docs="$3"
	local dir=/usr/share/${PN}/$subdir
	insinto ${dir}
	exeinto ${dir}
	for i in $bins ; do
		doexe scripts/$subdir/$i
	done
	for i in $docs ; do
		newdoc scripts/$subdir/$i $subdir.$i
	done
}
