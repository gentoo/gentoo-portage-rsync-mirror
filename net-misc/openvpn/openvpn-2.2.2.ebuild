# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-2.2.2.ebuild,v 1.15 2012/09/09 17:15:31 jlec Exp $

EAPI=4

inherit eutils multilib toolchain-funcs flag-o-matic user

DESCRIPTION="Robust and highly flexible tunneling application compatible with many OSes"
SRC_URI="http://swupdate.openvpn.net/community/releases/${P}.tar.gz"
HOMEPAGE="http://openvpn.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="examples iproute2 minimal pam passwordsave selinux +ssl static pkcs11 userland_BSD"

DEPEND=">=dev-libs/lzo-1.07
	kernel_linux? (
		iproute2? ( sys-apps/iproute2[-minimal] ) !iproute2? ( sys-apps/net-tools )
	)
	!minimal? ( pam? ( virtual/pam ) )
	selinux? ( sec-policy/selinux-openvpn )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	pkcs11? ( >=dev-libs/pkcs11-helper-1.05 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.2.2-pkcs11.patch"
	sed -i \
		-e "s/gcc \${CC_FLAGS}/\${CC} \${CFLAGS} -Wall/" \
		-e "s/-shared/-shared \${LDFLAGS}/" \
		plugin/*/Makefile || die "sed failed"
}

src_configure() {
	# basic.h defines a type 'bool' that conflicts with the altivec
	# keyword bool which has to be fixed upstream, see bugs #293840
	# and #297854.
	# For now, filter out -maltivec on ppc and append -mno-altivec, as
	# -maltivec is enabled implicitly by -mcpu and similar flags.
	(use ppc || use ppc64) && filter-flags -maltivec && append-flags -mno-altivec

	local myconf=""

	if use minimal ; then
		myconf="${myconf} --disable-plugins"
		myconf="${myconf} --disable-pkcs11"
	else
		myconf="$(use_enable pkcs11)"
	fi

	econf ${myconf} \
		$(use_enable passwordsave password-save) \
		$(use_enable ssl) \
		$(use_enable ssl crypto) \
		$(use_enable iproute2) \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}

src_compile() {

	if use static ; then
		sed -i -e '/^LIBS/s/LIBS = /LIBS = -static /' Makefile || die "sed failed"
	fi

	emake

	if ! use minimal ; then
		cd plugin
		for i in *; do
			[[ ${i} == "README" || ${i} == "examples" || ${i} == "defer" ]] && continue
			[[ ${i} == "auth-pam" ]] && ! use pam && continue
			einfo "Building ${i} plugin"
			emake -C "${i}" CC=$(tc-getCC) TARGET_DIR="${EPREFIX}"/usr/$(get_libdir)/${PN} || die "make failed"
		done
		cd ..
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	# install openvpn-plugin.h
	insinto /usr/include
	doins openvpn-plugin.h

	# install documentation
	dodoc AUTHORS ChangeLog PORTS README

	# Install some helper scripts
	keepdir /etc/openvpn
	exeinto /etc/openvpn
	doexe "${FILESDIR}/up.sh"
	doexe "${FILESDIR}/down.sh"

	# Install the init script and config file
	newinitd "${FILESDIR}/${PN}-2.1.init" openvpn
	newconfd "${FILESDIR}/${PN}-2.1.conf" openvpn

	# install examples, controlled by the respective useflag
	if use examples ; then
		# dodoc does not supportly support directory traversal, #15193
		insinto /usr/share/doc/${PF}/examples
		doins -r sample-{config-files,keys,scripts} contrib
	fi

	# Install plugins and easy-rsa
	doenvd "${FILESDIR}/65openvpn" # config-protect easy-rsa
	if ! use minimal ; then
		cd easy-rsa/2.0
		make install "DESTDIR=${D}" "PREFIX=${EPREFIX}/usr/share/${PN}/easy-rsa"
		cd ../..

		exeinto "/usr/$(get_libdir)/${PN}"
		doexe plugin/*/*.so
	fi
}

pkg_postinst() {
	# Add openvpn user so openvpn servers can drop privs
	# Clients should run as root so they can change ip addresses,
	# dns information and other such things.
	enewgroup openvpn
	enewuser openvpn "" "" "" openvpn

	if [ path_exists -o "${EROOT}/etc/openvpn/*/local.conf" ] ; then
		ewarn "WARNING: The openvpn init script has changed"
		ewarn ""
	fi

	elog "The openvpn init script expects to find the configuration file"
	elog "openvpn.conf in /etc/openvpn along with any extra files it may need."
	elog ""
	elog "To create more VPNs, simply create a new .conf file for it and"
	elog "then create a symlink to the openvpn init script from a link called"
	elog "openvpn.newconfname - like so"
	elog "   cd /etc/openvpn"
	elog "   ${EDITOR##*/} foo.conf"
	elog "   cd /etc/init.d"
	elog "   ln -s openvpn openvpn.foo"
	elog ""
	elog "You can then treat openvpn.foo as any other service, so you can"
	elog "stop one vpn and start another if you need to."

	if grep -Eq "^[ \t]*(up|down)[ \t].*" "${EROOT}/etc/openvpn"/*.conf 2>/dev/null ; then
		ewarn ""
		ewarn "WARNING: If you use the remote keyword then you are deemed to be"
		ewarn "a client by our init script and as such we force up,down scripts."
		ewarn "These scripts call /etc/openvpn/\$SVCNAME-{up,down}.sh where you"
		ewarn "can move your scripts to."
	fi

	if ! use minimal ; then
		einfo ""
		einfo "plugins have been installed into /usr/$(get_libdir)/${PN}"
	fi
}
