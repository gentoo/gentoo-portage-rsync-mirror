# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafaxplus/hylafaxplus-5.5.1.ebuild,v 1.1 2012/04/05 17:57:40 mattm Exp $

EAPI="2"

inherit eutils multilib pam toolchain-funcs

MY_PN=${PN/plus/}
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enterprise client-server fax package for class 1 and 2 fax modems."
HOMEPAGE="http://hylafax.sourceforge.net"
SRC_URI="mirror://sourceforge/hylafax/${MY_P}.tar.gz"

SLOT="0"
LICENSE="hylafaxplus"
KEYWORDS=""

IUSE="jbig pam mgetty html ldap"

DEPEND=">=sys-libs/zlib-1.1.4
	!net-misc/hylafax
	app-text/ghostscript-gpl
	virtual/mta
	media-libs/tiff[jbig?]
	virtual/jpeg
	jbig? ( media-libs/jbigkit )
	sys-apps/gawk
	ldap? (  net-nds/openldap )
	pam? ( virtual/pam )
	mgetty? ( net-dialup/mgetty[-fax] )"

RDEPEND="${DEPEND}
	net-mail/metamail
	!net-dialup/sendpage"

S=${WORKDIR}/${MY_P}

export CONFIG_PROTECT="${CONFIG_PROTECT} /var/spool/fax/etc /usr/lib/fax"

src_prepare() {
	epatch "${FILESDIR}/ldconfig-patch"
	# force it not to strip binaries
	for dir in etc util faxalter faxcover faxd faxmail faxrm faxstat \
		hfaxd sendfax sendpage ; do
			sed -i -e "s:-idb:-idb \"nostrip\" -idb:g" \
				"${dir}"/Makefile.in || die "sed failed"
	done

	sed -i -e "s|-fpic|-fPIC|g" \
		configure || die
}

src_configure() {
	local my_conf="
		--with-DIR_BIN=/usr/bin
		--with-DIR_SBIN=/usr/sbin
		--with-DIR_LIB=/usr/$(get_libdir)
		--with-DIR_LIBEXEC=/usr/sbin
		--with-DIR_LIBDATA=/usr/$(get_libdir)/fax
		--with-DIR_LOCALE=/usr/share/locale
		--with-DIR_LOCKS=/var/lock
		--with-DIR_MAN=/usr/share/man
		--with-DIR_SPOOL=/var/spool/fax
		--with-DIR_HTML=/usr/share/doc/${P}/html
		--with-DIR_CGI="${WORKDIR}"
		--with-PATH_DPSRIP=/var/spool/fax/bin/ps2fax
		--with-PATH_IMPRIP=\"\"
		--with-SYSVINIT=no
		--with-REGEX=yes
		--with-LIBTIFF=\"-ltiff -ljpeg -lz\"
		--with-OPTIMIZER=\"${CFLAGS}\"
		--with-DSO=auto"

	if use html; then
		my_conf="${my_conf} --with-HTML=yes"
	else
		my_conf="${my_conf} --with-HTML=no"
	fi

	if use mgetty; then
		my_conf="${my_conf} \
			--with-PATH_GETTY=/sbin/mgetty \
			--with-PATH_EGETTY=/sbin/mgetty \
			--with-PATH_VGETTY=/usr/sbin/vgetty"
	else
		# GETTY defaults to /sbin/agetty
		my_conf="${my_conf} \
			--with-PATH_EGETTY=/bin/false \
			--with-PATH_VGETTY=/bin/false"
	fi

	if [ -h /etc/localtime ]; then
		local continent=$(readlink /etc/localtime | cut -d / -f 5)
		if [ "${continent}" == "Europe" ]; then
			my_conf="${my_conf} --with-PAGESIZE=A4"
		fi
	fi

	#--enable-pam isn't valid
	use pam || my_conf="${my_conf} $(use_enable pam)"
	use ldap || my_conf="${my_conf} $(use_enable ldap)"
	use jbig || my_conf="${my_conf} $(use_enable jbig)"

	myconf="CC=$(tc-getCC) CXX=$(tc-getCXX) ${my_conf}"

	# eval required for quoting in ${my_conf} to work properly, better way?
	eval ./configure --nointeractive ${my_conf} || die "./configure failed"
}

src_install() {
	dodir /usr/{bin,sbin} /usr/$(get_libdir)/fax /usr/share/man
	dodir /var/spool /var/spool/recvq
	fowners uucp:uucp /var/spool/fax
	fperms 0600 /var/spool/fax
	dodir /usr/share/doc/${P}/samples

	emake \
		BIN=${D}/usr/bin \
		SBIN=${D}/usr/sbin \
		LIBDIR=${D}/usr/$(get_libdir) \
		LIB=${D}/usr/$(get_libdir) \
		LIBEXEC=${D}/usr/sbin \
		LIBDATA=${D}/usr/$(get_libdir)/fax \
		DIR_LOCALE=${D}/usr/share/locale \
		MAN=${D}/usr/share/man \
		SPOOL=${D}/var/spool/fax \
		HTMLDIR=${D}/usr/share/doc/${P}/html \
		install DESTDIR="${D}" || die "make install failed"

	keepdir /var/spool/fax/{archive,client,etc,pollq,recvq,tmp}
	keepdir /var/spool/fax/{status,sendq,log,info,doneq,docq,dev}

	dosed "s:hostname:hostname -f:g" /var/spool/fax/bin/{faxrcvd,pollrcvd} \
		|| die "dosed hostname failed"

	generate_files # in this case, it only generates the env.d entry

	einfo "Adding env.d entry for ${PN}"
	doenvd 99${P}

	einfo "Adding init.d and conf.d entries for ${PN}"
	newconfd "${FILESDIR}"/${PN}-conf ${PN}
	newinitd "${FILESDIR}"/${PN}-init ${PN}

	use pam && pamd_mimic_system ${MY_PN} auth account session

	dodoc CONTRIBUTORS README TODO
	docinto samples
}

pkg_postinst() {
	elog
	elog "The faxonly USE flag has been removed; since ${PN} does not"
	elog "require mgetty, and certain fax files conflict, you must build"
	elog "mgetty without fax support if you wish to use them both.  You"
	elog "may want to add both to package.use so any future updates are"
	elog "correctly built:"
	elog
	elog "	net-dialup/mgetty -fax"
	elog "	net-misc/hylafax [-mgetty|mgetty]"
	elog
	elog "There are additional files included in the documentation dir."
	elog
	elog "Note 1: hylafax.cron is provided for vixie-cron users and"
	elog "should be placed in /etc/cron.d.  Use as-is or adapt it to"
	elog "your system config."
	elog
	elog "Note 2: if you need to use hylafax with iptables, then you"
	elog "need to specify the port and use ip_conntrack_ftp as shown"
	elog "in the included example modules file."
	elog
	elog "See the docs and man pages for detailed configuration info."
	elog
	elog "Now run faxsetup and (if necessary) faxaddmodem."
	elog
}

generate_files() {
	cat <<-EOF > 99${P}
	PATH="/var/spool/fax/bin"
	CONFIG_PROTECT="/var/spool/fax/etc /usr/$(get_libdir)/fax"
	EOF
}
