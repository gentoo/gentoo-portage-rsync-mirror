# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-2.3.14.ebuild,v 1.6 2012/05/01 18:24:10 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="amd64 ~hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend ">=dev-ruby/builder-2.1.2:0 >=dev-ruby/tzinfo-0.3.16 >=dev-ruby/i18n-0.4.1:0.4"

all_ruby_prepare() {
	# Remove the bundled packages!
	rm -r lib/active_support/vendor/{tzinfo,builder,i18n}-* \
		|| die "failed to remove vendor packages"

	# This patch removes the fallback to local vendorized gems, as
	# well as fixing the dependencies for i18n to use the correct
	# slot.
	epatch "${FILESDIR}"/${PN}-2.3.9-unvendorize.patch

	# don't support older mocha versions as the optional codepath
	# breaks JRuby
	epatch "${FILESDIR}"/${PN}-2.3.5-mocha-0.9.5.patch
}
