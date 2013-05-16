# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-3.2.4.ebuild,v 1.7 2013/05/16 15:43:23 ago Exp $

EAPI="3"

MY_PV="${PV//_beta/b}"
MY_PV="${MY_PV/_p/p}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An automated suite of programs for configuring and maintaining
Unix-like computers"
HOMEPAGE="http://www.cfengine.org/"
SRC_URI="http://cfengine.com/source-code/download?file=${MY_P}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64 arm ppc ppc64 ~s390 sparc x86"

# libvirt disabled for now because it blocks stabilization etc.
IUSE="examples html mysql postgres qdbm selinux tests tokyocabinet vim-syntax"

# libvirt? ( app-emulation/libvirt )
DEPEND=">=sys-libs/db-4
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	selinux? ( sys-libs/libselinux )
	tokyocabinet? ( dev-db/tokyocabinet )
	!tokyocabinet? ( qdbm? ( dev-db/qdbm ) )
	!tokyocabinet? ( !qdbm? ( >=sys-libs/db-4 ) )
	>=dev-libs/openssl-0.9.7
	dev-libs/libpcre"
RDEPEND="${DEPEND}"
PDEPEND="vim-syntax? ( app-vim/cfengine-syntax )"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local myconf

	# BDB by default, prefer tokyocabinet above qdbm...
	# sqlite3 has been added but stated as experimental/broken...
	if ! use qdbm && ! use tokyocabinet; then
		myconf="${myconf} --with-berkeleydb=/usr"
	elif use qdbm && use tokyocabinet; then
		elog "QDBM and Tokyo Cabinet can't be used together, using Tokyo Cabinet by default"
		myconf="${myconf} --with-tokyocabinet"
	elif use qdbm && ! use tokyocabinet; then
		myconf="${myconf} --with-qdbm"
	elif ! use qdbm && use tokyocabinet; then
		myconf="${myconf} --with-tokyocabinet"
	fi

	# Enforce /var/cfengine for historical compatibility
	# $(use_with libvirt) \
	econf \
		--docdir=/usr/share/doc/"${PF}" \
		--with-workdir=/var/cfengine \
		--with-pcre \
		${myconf} \
		$(use_with postgres postgresql) \
		$(use_with mysql) \
		$(use_enable selinux)

	# Fix Makefile to skip inputs, see below "examples"
	#sed -i -e 's/\(SUBDIRS.*\) inputs/\1/' Makefile || die

	# We install documentation through portage
	sed -i -e 's/\(install-data-am.*\) install-docDATA/\1/' Makefile || die
}

src_install() {
	newinitd "${FILESDIR}"/cf-serverd.rc6 cf-serverd || die
	newinitd "${FILESDIR}"/cf-monitord.rc6 cf-monitord || die
	newinitd "${FILESDIR}"/cf-execd.rc6 cf-execd || die

	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README INSTALL

	if ! use examples; then
		rm -rf "${D}"/usr/share/doc/${PF}/example*
	fi

	# Create cfengine working directory
	dodir /var/cfengine/bin
	fperms 700 /var/cfengine

	# Copy cfagent into the cfengine tree otherwise cfexecd won't
	# find it. Most hosts cache their copy of the cfengine
	# binaries here. This is the default search location for the
	# binaries.
	for bin in know promises agent monitord serverd execd runagent key report; do
		dosym /usr/sbin/cf-$bin /var/cfengine/bin/cf-$bin || die
	done

	if use html; then
		docinto html
		dohtml -r docs/ || die
	fi
}

pkg_postinst() {
	echo
	einfo "Init scripts for cf-serverd, cf-monitord, and cf-execd are provided."
	einfo
	einfo "To run cfengine out of cron every half hour modify your crontab:"
	einfo "0,30 * * * *    /usr/sbin/cf-execd -F"
	echo

	elog "If you run cfengine the very first time, you MUST generate the keys for cfengine by running:"
	elog "emerge --config ${CATEGORY}/${PN}"

	# Fix old cf-servd, remove it after some releases.
	local found=0
	for fname in $(find /etc/runlevels/ -type f -or -type l -name 'cf-servd'); do
		found=1
		rm $fname
		ln -s /etc/init.d/cf-serverd $(echo $fname | sed 's:cf-servd:cf-serverd:')
	done

	if [ "${found}" -eq 1 ]; then
		echo
		elog "/etc/init.d/cf-servd has been renamed to /etc/init.d/cf-serverd"
	fi
}

pkg_config() {
	if [ "${ROOT}" == "/" ]; then
		if [ ! -f "/var/cfengine/ppkeys/localhost.priv" ]; then
			einfo "Generating keys for localhost."
			/usr/sbin/cf-key
		fi
	else
		die "cfengine cfkey does not support any value of ROOT other than /."
	fi
}
