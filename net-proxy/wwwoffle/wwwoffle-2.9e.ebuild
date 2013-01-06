# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/wwwoffle/wwwoffle-2.9e.ebuild,v 1.6 2012/08/01 19:49:05 jer Exp $

EAPI="2"

inherit user

DESCRIPTION="Web caching proxy suitable for non-permanent Internet connections"
SRC_URI="http://www.gedanken.demon.co.uk/download-wwwoffle/${P}.tgz"
HOMEPAGE="http://www.gedanken.demon.co.uk/wwwoffle"

KEYWORDS="amd64 ppc ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="gnutls ipv6 zlib"

RDEPEND="gnutls? ( net-libs/gnutls )
	zlib? ( sys-libs/zlib )"
DEPEND="dev-lang/perl
	sys-devel/flex
	${RDEPEND}"

# Unsure whether to depend on >=www-misc/htdig-3.1.6-r4 or not

src_prepare() {
	sed -i -e 's#$(TAR) xpf #$(TAR) --no-same-owner -xpf #' \
		"${S}/cache/Makefile.in"
}

src_configure() {
	econf $(use_with zlib) \
		$(use_with gnutls) \
		$(use_with ipv6) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# documentation fix
	# del empty doc dirs
	rmdir "${D}/usr/doc/${PN}"/{it,nl,ru}
	dodir /usr/share/doc
	mv "${D}/usr/doc/wwwoffle" "${D}/usr/share/doc/${PF}"
	rmdir "${D}/usr/doc"

	# install the wwwoffled init script
	newinitd "${FILESDIR}/${PN}.initd" wwwoffled
	newinitd "${FILESDIR}/${PN}-online.initd" wwwoffled-online
	newconfd "${FILESDIR}/${PN}-online.confd" wwwoffled-online

	keepdir /var/spool/wwwoffle/{http,outgoing,monitor,lasttime,lastout,local}
	for number in 1 2 3 4 5 6 7 8 9; do
		keepdir "/var/spool/wwwoffle/prevtime${number}" "/var/spool/wwwoffle/prevout${number}"
	done

	# empty dirs are removed during update
	keepdir \
		/var/spool/wwwoffle/search/{mnogosearch/db,htdig/tmp,htdig/db-lasttime,htdig/db,namazu/db}

	touch \
		"${D}/var/spool/wwwoffle/search/htdig/wwwoffle-htdig.log" \
		"${D}/var/spool/wwwoffle/search/mnogosearch/wwwoffle-mnogosearch.log" \
		"${D}/var/spool/wwwoffle/search/namazu/wwwoffle-namazu.log"

	# TODO htdig indexing as part of initscripts

	# robots.txt modification - /var/spool/wwwoffle/html/en
	# 		- remove Disallow: /index
	sed -i -e "s|Disallow:.*/index|#Disallow: /index|" "${D}/var/spool/wwwoffle/html/en/robots.txt"
}

pkg_preinst() {
	# Add a wwwoffle user
	enewgroup wwwoffle
	enewuser wwwoffle -1 -1 /var/spool/wwwoffle wwwoffle

	# Changing the user:group to wwwoffle:woffle
	fowners -R wwwoffle:wwwoffle /var/spool/wwwoffle /etc/wwwoffle
	sed -i -e 's/^[# \t]\(run-[gu]id[ \t]*=[ \t]*\)[a-zA-Z0-9]*[ \t]*$/ \1wwwoffle/g' \
		"${D}/etc/wwwoffle/wwwoffle.conf"

	# Stop the service if it is started
	if [ "${ROOT}" = "/" ] ; then
		source /etc/init.d/functions.sh
		if [ -L "${svcdir}/started/wwwoffled" ]; then
			einfo "The wwwoffled init script is running. I'll stop it, merge the new files and
			restart the script."
			/etc/init.d/wwwoffled stop
			# Just to be sure...
			start-stop-daemon --stop --quiet --name wwwoffled
			touch "${T}/stopped"
		fi
	fi
}

pkg_postinst() {
	# fix permissions for those upgrading
	for number in 1 2 3 4 5 6 7 8 9;
	do
		[ ! -d "${ROOT}/var/spool/wwwoffle/prevtime${number}" ] && \
			keepdir "${ROOT}/var/spool/wwwoffle/prevtime${number}"
		[ ! -d "${ROOT}/var/spool/wwwoffle/prevout${number}" ] && \
			keepdir "${ROOT}/var/spool/wwwoffle/prevout${number}"
	done
	chown -R wwwoffle:wwwoffle "${ROOT}/var/spool/wwwoffle" "${ROOT}/etc/wwwoffle"

	[ -f "${T}/stopped" ] && \
		ewarn "wwwoffled was stopped. /etc/init.d/wwwoffled start to restart AFTER etc-update"

	einfo "wwwoffled should run as an ordinary user now. The run-uid and run-gid should be set"
	einfo "to \"wwwoffle\" in your /etc/wwwoffle/wwwoffle.conf. Please uncomment this if it hasn't been already"

	einfo "This is for your own security. Otherwise wwwoffle is run as root which is relay bad if"
	einfo "there is an exploit in this program that allows remote/local users to execute arbitary"
	einfo "commands as the root user."

	if [ -f "${ROOT}/etc/wwwoffle.conf" ]; then
		ewarn "Configuration file is /etc/wwwoffle/wwwoffle.conf now"
		ewarn "Suggest you move ${ROOT}etc/wwwoffle.conf"
	fi

	# if htdig - run script for full database index
	# TODO
}
