# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-2.9.0.5.ebuild,v 1.6 2012/06/12 03:23:21 zmedico Exp $

EAPI="2"
inherit autotools multilib user

DESCRIPTION="The de facto standard for intrusion detection/prevention"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/dl/snort-current/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~mips"
IUSE="static +dynamicplugin +ipv6 +zlib gre mpls targetbased +decoder-preprocessor-rules
ppm perfprofiling linux-smp-stats inline-init-failopen prelude +threads debug
active-response normalizer reload-error-restart react flexresp3
aruba mysql odbc postgres selinux"

DEPEND=">=net-libs/libpcap-1.0.0
	>=net-libs/daq-0.5
	>=dev-libs/libpcre-6.0
	dev-libs/libdnet
	postgres? ( dev-db/postgresql-base )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	prelude? ( >=dev-libs/libprelude-0.9.0 )
	zlib? ( sys-libs/zlib )"

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-snort )"

pkg_setup() {

	if use zlib && ! use dynamicplugin; then
		eerror "You have enabled the 'zlib' USE flag but not the 'dynamicplugin' USE flag."
		eerror "'zlib' requires 'dynamicplugin' be enabled."
		die
	fi

	# pre_inst() is a better place to put this
	# but we need it here for the 'fowners' statements in src_install()
	enewgroup snort
	enewuser snort -1 -1 /dev/null snort

}

src_prepare() {

	# Fix to ensure that the package builds if USE flag -dynamicplugin is used.
#	epatch "${FILESDIR}/disabledynamic.patch"

	#Multilib fix for the sf_engine
	einfo "Applying multilib fix."
	sed -i -e 's:${exec_prefix}/lib:${exec_prefix}/'$(get_libdir)':g' \
		"${WORKDIR}/${P}/src/dynamic-plugins/sf_engine/Makefile.am" \
		|| die "sed for sf_engine failed"

	#Multilib fix for the curent set of dynamic-preprocessors
	for i in ftptelnet smtp ssh dns ssl dcerpc2 sdf; do
		sed -i -e 's:${exec_prefix}/lib:${exec_prefix}/'$(get_libdir)':g' \
			"${WORKDIR}/${P}/src/dynamic-preprocessors/$i/Makefile.am" \
			|| die "sed for $i failed."
	done

	if use prelude; then
		einfo "Applying prelude fix."
		sed -i -e "s:AC_PROG_RANLIB:AC_PROG_LIBTOOL:" configure.in \
			|| die "sed	for perlude failed"
	fi

	AT_M4DIR=m4 eautoreconf
}

src_configure() {

	econf \
		$(use_enable !static shared) \
		$(use_enable static) \
		$(use_enable dynamicplugin) \
		$(use_enable ipv6) \
		$(use_enable zlib) \
		$(use_enable gre) \
		$(use_enable mpls) \
		$(use_enable targetbased) \
		$(use_enable decoder-preprocessor-rules) \
		$(use_enable ppm) \
		$(use_enable perfprofiling) \
		$(use_enable linux-smp-stats) \
		$(use_enable inline-init-failopen) \
		$(use_enable prelude) \
		$(use_enable threads pthread) \
		$(use_enable debug) \
		$(use_enable debug debug-msgs) \
		$(use_enable debug corefiles) \
		$(use_enable !debug dlclose) \
		$(use_enable active-response) \
		$(use_enable normalizer) \
		$(use_enable reload-error-restart) \
		$(use_enable react) \
		$(use_enable flexresp3) \
		$(use_enable aruba) \
		$(use_with mysql) \
		$(use_with odbc) \
		$(use_with postgres postgresql) \
		--enable-reload \
		--disable-build-dynamic-examples \
		--disable-profile \
		--disable-ppm-test \
		--disable-intel-soft-cpm \
		--disable-static-daq \
		--disable-rzb-saac \
		--without-oracle

}

src_install() {

	emake DESTDIR="${D}" install || die "emake failed"

	dodir /var/log/snort \
		/var/run/snort \
		/etc/snort/rules \
		/usr/$(get_libdir)/snort_dynamicrules \
			|| die "Failed to create core directories"

	# config.log and build.log are needed by Sourcefire
	# to trouble shoot build problems and bug reports so we are
	# perserving them incase the user needs upstream support.
	dodoc RELEASE.NOTES ChangeLog \
		doc/* \
		tools/u2boat/README.u2boat \
		schemas/* || die "Failed to install snort docs"

	insinto /etc/snort
	doins etc/attribute_table.dtd \
		etc/classification.config \
		etc/gen-msg.map \
		etc/reference.config \
		etc/threshold.conf \
		etc/unicode.map || die "Failed to install docs in etc"

	# We use snort.conf.distrib because the config file is complicated
	# and the one shipped with snort can change drastically between versions.
	# Users should migrate setting by hand and not with etc-update.
	newins etc/snort.conf snort.conf.distrib \
		|| die "Failed to add snort.conf.distrib"

	insinto /etc/snort/preproc_rules
	doins preproc_rules/decoder.rules \
		preproc_rules/preprocessor.rules \
		preproc_rules/sensitive-data.rules || die "Failed to install preproc rule files"

	chown -R snort:snort \
		"${D}"/var/log/snort \
		"${D}"/var/run/snort \
		"${D}"/etc/snort \
		"${D}"/etc/snort/preproc_rules || die "Failed to set ownership of dirs"

	newinitd "${FILESDIR}/snort.rc10" snort || die "Failed to install snort init script"
	newconfd "${FILESDIR}/snort.confd" snort || die "Failed to install snort confd file"

	# Sourcefire uses Makefiles to install docs causing Bug #297190.
	# This removes the unwanted doc directory and rogue Makefiles.
	rm -rf "${D}"usr/share/doc/snort || die "Failed to remove SF doc directories"
	rm "${D}"usr/share/doc/"${PF}"/Makefile* || die "Failed to remove doc make files"

	# Set the correct lib path for dynamicengine, dynamicpreprocessor, and dynamicdetection
	sed -i -e 's:/usr/local/lib:/usr/'$(get_libdir)':g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to update snort.conf.distrib lib paths"

	# Set the correct rule location in the config
	sed -i -e 's:RULE_PATH ../rules:RULE_PATH /etc/snort/rules:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to update snort.conf.distrib rule path"

	# Set the correct preprocessor/decoder rule location in the config
	sed -i -e 's:PREPROC_RULE_PATH ../preproc_rules:PREPROC_RULE_PATH /etc/snort/preproc_rules:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to update snort.conf.distrib preproc rule path"

	# Enable the preprocessor/decoder rules
	sed -i -e 's:^# include $PREPROC_RULE_PATH:include $PREPROC_RULE_PATH:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to uncomment snort.conf.distrib preproc rule path"

	sed -i -e 's:^# dynamicdetection directory:dynamicdetection directory:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to uncomment snort.conf.distrib dynamicdetection directory"

	# Just some clean up of trailing /'s in the config
	sed -i -e 's:snort_dynamicpreprocessor/$:snort_dynamicpreprocessor:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to clean up snort.conf.distrib trailing slashes"

	# Make it clear in the config where these are...
	sed -i -e 's:^include classification.config:include /etc/snort/classification.config:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to update snort.conf.distrib classification.config path"

	sed -i -e 's:^include reference.config:include /etc/snort/reference.config:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to update snort.conf.distrib /etc/snort/reference.config path"

	# Disable all rule files by default. Users need to choose what they want enabled.
	sed -i -e 's:^include $RULE_PATH:# include $RULE_PATH:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to disable rules in snort.conf.distrib"

	# Disable preproc rule files by default.
	sed -i -e 's:^include $PREPROC_RULE_PATH:# include $PREPROC_RULE_PATH:g' \
		"${D}etc/snort/snort.conf.distrib" \
		|| die "Failed to disable rules in snort.conf.distrib"

	# Disable normalizer preprocessor config if normalizer USE flag not set.
	if ! use normalizer; then
		sed -i -e 's:^preprocessor normalize:#preprocessor normalize:g' \
			"${D}etc/snort/snort.conf.distrib" \
			|| die "Failed to disable normalizer config in snort.conf.distrib"
	fi

}

pkg_postinst() {
	elog
	elog "Snort-2.9 introduces the DAQ, or Data Acquisition library, for"
	elog "packet I/O. The DAQ replaces direct calls to PCAP functions with"
	elog "an abstraction layer that	facilitates operation on a variety of"
	elog "hardware and software interfaces without requiring changes to Snort."
	elog
	elog "The only DAQ modules supported with this ebuild are AFpacket, PCAP,"
	elog "and Dump. IPQ nad NFQ will be supported in future versions of this"
	elog "package."
	elog
	elog "For passive (non-inline) Snort deployments you will want to use"
	elog "either PCAP or AFpacket. For inline deployments you will need"
	elog "to use AFpacket. The Dump DAQ is used for testing the various inline"
	elog "features available in ${P}."
	elog
	elog "The core DQA libraries are installed in /usr/$(get_libdir)/. The libraries"
	elog "for the individual DAQ modules (afpacket,pcap,dump) are installed in"
	elog "/usr/$(get_libdir)/daq. To use these you will need to add the following"
	elog "lines to your snort.conf:"
	elog
	elog "config daq: <DAQ module>"
	elog "config daq_mode: <mode>"
	elog "config daq_dir: /usr/$(get_libdir)/daq"
	elog
	elog "Please see the README file for DAQ for information about specific"
	elog "DAQ modules and README.daq from the Snort 2.9 documentation"
	elog "reguarding Snort and DAQ configuration information."
	elog
	elog "See /usr/share/doc/${PF} and /etc/snort/snort.conf.distrib for"
	elog "information on configuring snort."
	elog

	if [[ $(date +%Y%m%d) < 20110507 ]]; then
		ewarn
		ewarn "Please note, you can not use ${P} with the SO rules from"
		ewarn "previous versions of Snort!"
		ewarn
		ewarn "If you do not have a subscription to the VRT rule set and you"
		ewarn "wish to continue using the shared object (SO) rules, you will"
		ewarn "need to downgrade Snort. The SO rules will be made available"
		ewarn "to registered (non-subscription) users on May 7, 2011"
		ewarn "(30 days after being released to subscription users)."
		ewarn
		ewarn "Please see http://www.snort.org/snort-rules/#rules for more"
		ewarn "details."
		ewarn
	fi

	if use debug; then
		elog "You have the 'debug' USE flag enabled. If this has been done to"
		elog "troubleshoot an issue by producing a core dump or a back trace,"
		elog "then you need to also ensure the FEATURES variable in make.conf"
		elog "contains the 'nostrip' option."
	fi
}
