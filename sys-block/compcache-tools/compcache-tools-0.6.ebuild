# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils toolchain-funcs

MY_P="${P/-tools/}"
DESCRIPTION="Compressed in-memory swap device for Linux"
HOMEPAGE="http://code.google.com/p/compcache/"
SRC_URI="http://compcache.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}/sub-projects/rzscontrol"

src_prepare() {
	epatch "${FILESDIR}/${P}_gentoo.patch"
}

src_compile() {
	tc-export CC
	default
}

src_install() {
	dobin rzscontrol || die
	doman man/rzscontrol.1 || die
}
