# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.6.0.ebuild,v 1.8 2012/12/02 18:58:29 graaff Exp $

EAPI="2"

USE_RUBY="ruby18 ree18 jruby"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"
RUBY_FAKEGEM_BINWRAP="facter"

inherit ruby-fakegem

DESCRIPTION="A cross-platform Ruby library for retrieving facts from operating systems"
HOMEPAGE="http://www.puppetlabs.com/puppet/related-projects/facter/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
KEYWORDS="amd64 hppa ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"

RDEPEND+="<sys-apps/net-tools-1.60_p20120127084908"

ruby_add_bdepend "test? (
		dev-ruby/mocha
		dev-ruby/rspec:2
	)"
