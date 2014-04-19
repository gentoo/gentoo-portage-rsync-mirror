# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/slop/slop-2.4.4-r1.ebuild,v 1.2 2014/04/19 03:17:57 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="A simple option parser with an easy to remember syntax and friendly API."
HOMEPAGE="https://github.com/injekt/slop"
SRC_URI="https://github.com/injekt/slop/tarball/v${PV} -> ${P}.tgz"
RUBY_S="injekt-slop-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest )"
